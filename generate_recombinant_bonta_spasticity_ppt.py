"""
Generate a report-ready PPTX (Chinese) summarizing recombinant BoNT/A R&D progress
for adult upper limb spasticity.

Output:
  /workspace/重组A型肉毒毒素_成人上肢痉挛_国内外研发现状_可汇报版.pptx

Notes:
  - This deck intentionally avoids naming specific pipelines unless they are
    verifiable from public registries/papers. It includes a "pipeline tracking"
    table template to be filled with registry IDs and latest nodes.
"""

from __future__ import annotations

from datetime import date
from typing import Iterable, Optional

from pptx import Presentation
from pptx.dml.color import RGBColor
from pptx.enum.shapes import MSO_AUTO_SHAPE_TYPE
from pptx.enum.text import PP_ALIGN
from pptx.util import Inches, Pt


TODAY = date.today().isoformat()
OUTPUT_PPTX = "/workspace/重组A型肉毒毒素_成人上肢痉挛_国内外研发现状_可汇报版.pptx"


class Theme:
    bg = RGBColor(255, 255, 255)
    brand = RGBColor(12, 53, 106)  # deep blue
    brand2 = RGBColor(30, 90, 160)  # lighter blue
    text = RGBColor(25, 25, 25)
    muted = RGBColor(90, 90, 90)
    line = RGBColor(220, 228, 238)


def set_widescreen(prs: Presentation) -> None:
    # 13.333 x 7.5 inches (16:9)
    prs.slide_width = Inches(13.333)
    prs.slide_height = Inches(7.5)


def add_header(prs: Presentation, slide, title: str, subtitle: Optional[str] = None) -> None:
    width = prs.slide_width
    header_h = Inches(0.75)

    header = slide.shapes.add_shape(
        MSO_AUTO_SHAPE_TYPE.RECTANGLE, 0, 0, width, header_h
    )
    header.fill.solid()
    header.fill.fore_color.rgb = Theme.brand
    header.line.fill.background()

    tf = header.text_frame
    tf.clear()
    p = tf.paragraphs[0]
    r = p.add_run()
    r.text = title
    r.font.name = "Calibri"
    r.font.size = Pt(24)
    r.font.bold = True
    r.font.color.rgb = RGBColor(255, 255, 255)
    p.alignment = PP_ALIGN.LEFT
    tf.margin_left = Inches(0.5)
    tf.margin_right = Inches(0.5)

    if subtitle:
        box = slide.shapes.add_textbox(Inches(0.55), Inches(0.82), width - Inches(1.1), Inches(0.35))
        tf2 = box.text_frame
        tf2.clear()
        p2 = tf2.paragraphs[0]
        p2.text = subtitle
        p2.font.name = "Calibri"
        p2.font.size = Pt(14)
        p2.font.color.rgb = Theme.muted


def add_footer(prs: Presentation, slide, right_text: str = TODAY) -> None:
    width = prs.slide_width
    y = prs.slide_height - Inches(0.35)
    box = slide.shapes.add_textbox(Inches(0.5), y, width - Inches(1.0), Inches(0.3))
    tf = box.text_frame
    tf.clear()
    p = tf.paragraphs[0]
    p.text = right_text
    p.font.name = "Calibri"
    p.font.size = Pt(10)
    p.font.color.rgb = Theme.muted
    p.alignment = PP_ALIGN.RIGHT


def add_title_slide(prs: Presentation) -> None:
    slide = prs.slides.add_slide(prs.slide_layouts[6])  # blank
    width = prs.slide_width
    height = prs.slide_height

    # Top band
    band = slide.shapes.add_shape(MSO_AUTO_SHAPE_TYPE.RECTANGLE, 0, 0, width, Inches(1.2))
    band.fill.solid()
    band.fill.fore_color.rgb = Theme.brand
    band.line.fill.background()

    title_box = slide.shapes.add_textbox(Inches(0.8), Inches(0.35), width - Inches(1.6), Inches(1.2))
    tf = title_box.text_frame
    tf.clear()
    p = tf.paragraphs[0]
    p.text = "重组A型肉毒毒素（rBoNT/A）用于成人上肢痉挛\n国内外药物研发进展（可汇报版）"
    p.font.name = "Calibri"
    p.font.size = Pt(34)
    p.font.bold = True
    p.font.color.rgb = RGBColor(255, 255, 255)
    p.alignment = PP_ALIGN.LEFT

    sub = slide.shapes.add_textbox(Inches(0.82), Inches(1.75), width - Inches(1.64), Inches(0.8))
    tf2 = sub.text_frame
    tf2.clear()
    p2 = tf2.paragraphs[0]
    p2.text = (
        "范围：成人上肢痉挛（Adult Upper Limb Spasticity, AULS）\n"
        "口径：以可核验公开信息为主（注册库/论文/会议摘要），企业新闻仅作为线索"
    )
    p2.font.name = "Calibri"
    p2.font.size = Pt(16)
    p2.font.color.rgb = Theme.text

    # Key box
    box = slide.shapes.add_shape(
        MSO_AUTO_SHAPE_TYPE.ROUNDED_RECTANGLE, Inches(0.8), Inches(3.0), width - Inches(1.6), Inches(3.4)
    )
    box.fill.solid()
    box.fill.fore_color.rgb = RGBColor(245, 248, 252)
    box.line.color.rgb = Theme.line
    tf3 = box.text_frame
    tf3.clear()
    p3 = tf3.paragraphs[0]
    p3.text = "用于汇报的建议使用方式："
    p3.font.name = "Calibri"
    p3.font.size = Pt(18)
    p3.font.bold = True
    p3.font.color.rgb = Theme.brand
    for t in [
        "面向管理层：重点讲“结论页 + 关键瓶颈/风险 + 路线图/建议”",
        "面向研发/注册：重点讲“CMC与效价体系 + 试验设计与终点 + 免疫原性/重复给药”",
        "如需落到具体品种：用附录的“项目跟踪表模板”补齐注册号/最新节点",
    ]:
        pp = tf3.add_paragraph()
        pp.text = t
        pp.level = 1
        pp.font.name = "Calibri"
        pp.font.size = Pt(14)
        pp.font.color.rgb = Theme.text

    add_footer(prs, slide, right_text=f"版本：{TODAY}")


def add_bullets_slide(
    prs: Presentation,
    title: str,
    bullets: Iterable[str],
    subtitle: Optional[str] = None,
    note: Optional[str] = None,
) -> None:
    slide = prs.slides.add_slide(prs.slide_layouts[6])
    add_header(prs, slide, title, subtitle=subtitle)

    box = slide.shapes.add_shape(
        MSO_AUTO_SHAPE_TYPE.ROUNDED_RECTANGLE,
        Inches(0.6),
        Inches(1.25),
        prs.slide_width - Inches(1.2),
        prs.slide_height - Inches(1.85),
    )
    box.fill.solid()
    box.fill.fore_color.rgb = RGBColor(255, 255, 255)
    box.line.color.rgb = Theme.line

    tf = box.text_frame
    tf.clear()
    tf.word_wrap = True
    first = True
    for b in bullets:
        if first:
            p = tf.paragraphs[0]
            first = False
        else:
            p = tf.add_paragraph()
        p.text = b
        p.level = 0
        p.font.name = "Calibri"
        p.font.size = Pt(18)
        p.font.color.rgb = Theme.text
        p.space_after = Pt(6)

    if note:
        nb = slide.notes_slide.notes_text_frame
        nb.text = note

    add_footer(prs, slide)


def add_two_column_slide(
    prs: Presentation,
    title: str,
    left_title: str,
    left_bullets: Iterable[str],
    right_title: str,
    right_bullets: Iterable[str],
    subtitle: Optional[str] = None,
    note: Optional[str] = None,
) -> None:
    slide = prs.slides.add_slide(prs.slide_layouts[6])
    add_header(prs, slide, title, subtitle=subtitle)

    col_w = (prs.slide_width - Inches(1.4)) / 2
    y = Inches(1.25)
    h = prs.slide_height - Inches(1.85)

    for idx, (ctitle, cbullets, x) in enumerate(
        [
            (left_title, left_bullets, Inches(0.6)),
            (right_title, right_bullets, Inches(0.8) + col_w),
        ]
    ):
        box = slide.shapes.add_shape(MSO_AUTO_SHAPE_TYPE.ROUNDED_RECTANGLE, x, y, col_w, h)
        box.fill.solid()
        box.fill.fore_color.rgb = RGBColor(255, 255, 255)
        box.line.color.rgb = Theme.line

        hdr = slide.shapes.add_shape(MSO_AUTO_SHAPE_TYPE.RECTANGLE, x, y, col_w, Inches(0.5))
        hdr.fill.solid()
        hdr.fill.fore_color.rgb = Theme.brand2
        hdr.line.fill.background()
        tfh = hdr.text_frame
        tfh.clear()
        ph = tfh.paragraphs[0]
        ph.text = ctitle
        ph.font.name = "Calibri"
        ph.font.size = Pt(16)
        ph.font.bold = True
        ph.font.color.rgb = RGBColor(255, 255, 255)
        tfh.margin_left = Inches(0.25)

        content = slide.shapes.add_textbox(x + Inches(0.25), y + Inches(0.65), col_w - Inches(0.5), h - Inches(0.8))
        tf = content.text_frame
        tf.clear()
        tf.word_wrap = True
        first = True
        for b in cbullets:
            if first:
                p = tf.paragraphs[0]
                first = False
            else:
                p = tf.add_paragraph()
            p.text = b
            p.level = 0
            p.font.name = "Calibri"
            p.font.size = Pt(15)
            p.font.color.rgb = Theme.text
            p.space_after = Pt(2)

    if note:
        slide.notes_slide.notes_text_frame.text = note
    add_footer(prs, slide)


def add_table_slide(
    prs: Presentation,
    title: str,
    columns: list[str],
    rows: list[list[str]],
    subtitle: Optional[str] = None,
    note: Optional[str] = None,
) -> None:
    slide = prs.slides.add_slide(prs.slide_layouts[6])
    add_header(prs, slide, title, subtitle=subtitle)

    x = Inches(0.6)
    y = Inches(1.35)
    w = prs.slide_width - Inches(1.2)
    h = prs.slide_height - Inches(2.0)

    table_shape = slide.shapes.add_table(len(rows) + 1, len(columns), x, y, w, h)
    table = table_shape.table

    # set column widths evenly
    for i in range(len(columns)):
        table.columns[i].width = int(w / len(columns))

    # header
    for i, col in enumerate(columns):
        cell = table.cell(0, i)
        cell.text = col
        cell.fill.solid()
        cell.fill.fore_color.rgb = Theme.brand2
        for p in cell.text_frame.paragraphs:
            p.font.name = "Calibri"
            p.font.size = Pt(12)
            p.font.bold = True
            p.font.color.rgb = RGBColor(255, 255, 255)
            p.alignment = PP_ALIGN.CENTER

    # body
    for r, row in enumerate(rows, start=1):
        for c, val in enumerate(row):
            cell = table.cell(r, c)
            cell.text = val
            cell.fill.solid()
            cell.fill.fore_color.rgb = RGBColor(255, 255, 255) if r % 2 == 1 else RGBColor(248, 250, 253)
            for p in cell.text_frame.paragraphs:
                p.font.name = "Calibri"
                p.font.size = Pt(11)
                p.font.color.rgb = Theme.text
                p.alignment = PP_ALIGN.LEFT

    if note:
        slide.notes_slide.notes_text_frame.text = note
    add_footer(prs, slide)


def add_timeline_slide(prs: Presentation, title: str) -> None:
    slide = prs.slides.add_slide(prs.slide_layouts[6])
    add_header(prs, slide, title, subtitle="从“分子/CMC”到“临床证据”——AULS可行的开发路径（示例模板）")

    x0 = Inches(0.8)
    y0 = Inches(1.6)
    w = prs.slide_width - Inches(1.6)
    h = Inches(4.8)

    # baseline
    line = slide.shapes.add_shape(MSO_AUTO_SHAPE_TYPE.RECTANGLE, x0, y0 + Inches(2.2), w, Inches(0.05))
    line.fill.solid()
    line.fill.fore_color.rgb = Theme.line
    line.line.fill.background()

    steps = [
        ("分子设计/表达", ["亚型/结构优化", "折叠与二硫键", "激活切割策略"]),
        ("CMC与效价体系", ["参考品/单位体系", "体内外效价关联", "稳定性/杂质谱"]),
        ("I期/桥接探索", ["扩散/安全窗", "初步起效与持续", "注射肌群与剂量"]),
        ("II期剂量-反应", ["MAS为主+功能量表", "分层/中心效应处理", "敏感性与最小临床差异"]),
        ("III期确证+延伸", ["重复给药与免疫原性", "长期安全与耐受", "真实世界与支付证据"]),
    ]

    n = len(steps)
    step_w = w / n
    for i, (st, pts) in enumerate(steps):
        cx = x0 + step_w * i + step_w / 2
        # node
        node = slide.shapes.add_shape(
            MSO_AUTO_SHAPE_TYPE.OVAL,
            cx - Inches(0.22),
            y0 + Inches(2.05),
            Inches(0.44),
            Inches(0.44),
        )
        node.fill.solid()
        node.fill.fore_color.rgb = Theme.brand2
        node.line.color.rgb = Theme.brand2

        # title
        tb = slide.shapes.add_textbox(x0 + step_w * i + Inches(0.05), y0, step_w - Inches(0.1), Inches(0.6))
        tf = tb.text_frame
        tf.clear()
        p = tf.paragraphs[0]
        p.text = st
        p.font.name = "Calibri"
        p.font.size = Pt(14)
        p.font.bold = True
        p.font.color.rgb = Theme.brand
        p.alignment = PP_ALIGN.CENTER

        # bullets
        bb = slide.shapes.add_textbox(
            x0 + step_w * i + Inches(0.15), y0 + Inches(0.7), step_w - Inches(0.3), Inches(1.25)
        )
        tfb = bb.text_frame
        tfb.clear()
        first = True
        for t in pts:
            if first:
                pp = tfb.paragraphs[0]
                first = False
            else:
                pp = tfb.add_paragraph()
            pp.text = t
            pp.font.name = "Calibri"
            pp.font.size = Pt(11)
            pp.font.color.rgb = Theme.text
            pp.level = 0

    slide.notes_slide.notes_text_frame.text = (
        "说明：时间轴为“逻辑顺序模板”，非对某个具体品种的时间承诺。\n"
        "AULS的难点在于：注射肌群/剂量方案复杂、终点敏感性、重复给药免疫原性与真实世界可及性。"
    )
    add_footer(prs, slide)


def build_deck() -> Presentation:
    prs = Presentation()
    set_widescreen(prs)

    add_title_slide(prs)

    add_bullets_slide(
        prs,
        "一页结论（建议汇报先讲这页）",
        bullets=[
            "现有AULS一线药物仍以“天然来源的BoNT/A制剂”为主；重组rBoNT/A在该适应证公开证据总体偏早期/信息有限。",
            "rBoNT/A的核心价值在于：成分可控、可工程化（亚型/结构/持续时间）、更一致的CMC与供应链潜力，但实现难度高。",
            "决定成败的关键不是“做出蛋白”，而是“建立可监管/可复制的效价（potency）与单位体系 + 临床可解释的剂量-反应与持续时间证据”。",
            "AULS临床开发的主要风险：中心/操作者差异导致噪声、终点敏感性与功能获益不一致、重复给药免疫原性与长期安全边界。",
            "建议策略：先把CMC/效价体系做实（对标国际参考品与体内外关联）→ 通过II期明确剂量/肌群/终点敏感性 → 以长期延伸锁定重复给药与免疫原性。",
        ],
        subtitle="口径：以公开注册库/论文为主（截至制作日）",
        note="提示：若需要“点名公司/品种/分期”，请在附录表格中补齐注册号与最近一次更新节点，避免不可核验信息进入正式汇报。",
    )

    add_two_column_slide(
        prs,
        "适应证与临床背景（AULS）",
        left_title="AULS的临床特点（影响试验设计）",
        left_bullets=[
            "病因多样：卒中、脑外伤、脊髓损伤、脑瘫成人等；肌群受累谱不同。",
            "干预是“注射 + 康复”的组合疗法，操作者技术与中心流程差异大。",
            "剂量分配是“多肌群/多点位”决策，且存在再给药周期与个体化调整。",
            "功能获益（手功能/ADL）与痉挛改善（如MAS）并非总一致。",
        ],
        right_title="AULS常见主要终点/关键观测",
        right_bullets=[
            "主要终点常见：MAS（目标关节/肌群）变化；需明确评估窗口与标准化培训。",
            "辅终点：Tardieu、功能量表（如手功能/上肢活动）、患者/照护者报告结局。",
            "关键观测：起效时间、峰值、持续时间、扩散相关不良事件、疼痛/注射耐受。",
            "长期：重复给药反应一致性、抗体（免疫原性）与疗效衰减。",
        ],
        subtitle="成人上肢痉挛 = “终点敏感性 + 操作者差异 + 重复给药”三重挑战",
    )

    add_table_slide(
        prs,
        "现有主流BoNT/A治疗格局（对照参照）",
        columns=["类别", "代表产品（示例）", "典型特点", "对rBoNT/A的启示"],
        rows=[
            ["天然来源BoNT/A", "onabotulinumtoxinA / abobotulinumtoxinA / incobotulinumtoxinA", "单位不可互换；疗效与扩散/安全窗与制剂差异相关", "必须建立“自洽且可监管”的单位/效价体系"],
            ["配方/长效方向（不等同重组）", "通过辅料/递送或工艺改良延长持续时间（多适应证探索）", "以“持续时间/复注周期”形成差异化", "rBoNT/A若主打长效，需要更强的长期安全与免疫原性证据"],
            ["其他血清型/新机制", "不同血清型或新型神经肌肉调控策略（早期探索）", "可能在起效/持续/靶点上形成差异", "适应证与终点选择更关键，需谨慎外推到AULS"],
        ],
        subtitle="说明：AULS已存在成熟对照疗法，后续试验与注册需清晰定位差异化与临床获益",
        note="注意：表中为“类别级别”概览，避免在无法核验时点名在研品种细节。",
    )

    add_two_column_slide(
        prs,
        "为什么做重组rBoNT/A？（价值主张）",
        left_title="潜在优势（如果做得到）",
        left_bullets=[
            "成分可控：定义明确的分子实体与杂质谱，批间一致性更强。",
            "可工程化：亚型选择、结构修饰、可能的持续时间/扩散特性调控。",
            "供应链潜力：理论上更易规模化与质量体系标准化（依赖工艺成熟）。",
            "可做平台化：同一平台延展到多适应证/多剂型。",
        ],
        right_title="现实约束（决定可行性）",
        right_bullets=[
            "表达/折叠/二硫键与激活切割复杂，影响活性与一致性。",
            "效价测定与单位体系是“监管核心”，且与既有单位不可直接换算。",
            "AULS需较高总剂量/多肌群注射，安全窗、扩散与免疫原性压力更大。",
            "重复给药长期证据是进入临床常规应用的门槛。",
        ],
        subtitle="一句话：rBoNT/A的护城河在“CMC + 效价 + 长期临床证据”，而不是概念本身",
    )

    add_bullets_slide(
        prs,
        "关键技术瓶颈：从“能做”到“可注册/可商业化”",
        bullets=[
            "分子与工艺：正确折叠/二硫键、活化切割、结构异质性控制、稳定性与冷链策略。",
            "效价与单位：体内外方法学一致性、参考品建立、跨批次可比性、与临床剂量的关联证据。",
            "制剂与递送：扩散控制、注射痛/耐受、与超声/电刺激定位等临床流程的适配。",
            "免疫原性：抗体发生率、与疗效衰减关系、风险因素（剂量/复注周期/杂质）控制。",
            "临床可重复性：中心/操作者差异、标准化培训、盲法与评估一致性、统计策略（中心效应处理）。",
        ],
        subtitle="AULS是“高要求场景”：剂量更大、肌群更多、复注周期更长",
        note="统计学提醒：AULS多中心研究常受中心差异影响；若中心多且单中心入组少，固定效应校正会遇到估计不稳定、分离等问题，可考虑合并小中心、随机效应/分层、稳健方差或正则化等策略。",
    )

    add_timeline_slide(prs, "开发路径与里程碑（建议路线图）")

    add_two_column_slide(
        prs,
        "国际进展：公开信息可得的“方向”而非“名单”",
        left_title="国际常见研发方向（与rBoNT/A相关）",
        left_bullets=[
            "重组表达/工程化：尝试提升一致性、调控持续时间/扩散属性（多为早期）。",
            "长效化：延长复注周期（可能通过分子/配方/递送），但AULS需更强长期安全证据。",
            "方法学升级：更重视功能终点、患者报告结局、以及与康复路径结合。",
            "监管倾向：单位体系、效价一致性、以及与临床剂量-反应的可解释性。",
        ],
        right_title="对AULS的关键启示（做汇报的“可落地结论”）",
        right_bullets=[
            "即便在国际上，AULS也更倾向走“稳扎稳打”的证据路径：剂量-反应 → 确证 → 长期延伸。",
            "若差异化主张是“更长持续时间/更少复注”，需要提前设计长期队列与免疫原性监测。",
            "对标策略：应以“临床获益 + 风险窗口 + 真实世界可及性”三维定义竞品，而非仅比MAS。",
        ],
        subtitle="提示：如需“国际在研项目清单”，可按附录方法用注册库检索并补齐项目表",
    )

    add_two_column_slide(
        prs,
        "国内进展：现状判断与机会点（公开口径）",
        left_title="可公开核验的共性现状（中国）",
        left_bullets=[
            "临床使用层面：A型肉毒毒素治疗痉挛已较成熟，中心经验差异仍显著。",
            "重组rBoNT/A在AULS适应证：公开信息通常更少、分期偏早或尚未清晰披露。",
            "企业推进往往先从更“路径清晰”的适应证积累CMC/效价与安全数据，再延展到痉挛。",
        ],
        right_title="对国内申报/立项的建议（可用于汇报决策）",
        right_bullets=[
            "优先把“效价/单位体系 + 参考品 + 批间一致性”作为里程碑门槛；没有这块，临床很难解释。",
            "AULS II期必须把“剂量分配规则/肌群选择/评估窗口/评估培训”写成可复制SOP。",
            "提前规划长期延伸：重复给药（≥3个周期）、抗体监测、疗效衰减与安全性随访。",
            "中心效应控制：中心分层随机、最小入组阈值、合并小中心策略、盲评与一致性校准。",
        ],
        subtitle="结论表达建议：用“证据强度/可核验性”来讲国内外进展，避免不可核验细节",
    )

    add_table_slide(
        prs,
        "附录A：在研项目跟踪表（模板，建议用于点名汇报前“补齐证据”）",
        columns=["公司/机构", "分子形态", "适应证", "地区", "分期", "注册号/论文DOI", "关键终点", "最近更新节点"],
        rows=[
            ["（待补）", "rBoNT/A（重组/工程化）", "成人上肢痉挛", "国际/中国", "I/II/III", "ClinicalTrials/ChiCTR/NMPA/论文", "MAS±功能终点", "yyyy-mm-dd"],
            ["（待补）", "rBoNT/A（重组/工程化）", "成人上肢痉挛", "国际/中国", "I/II/III", "…", "…", "…"],
            ["（待补）", "（可加入对照：非重组或长效方向）", "AULS/其他", "…", "…", "…", "…", "…"],
        ],
        subtitle="使用方法：每个条目必须至少给出一个可核验来源（注册号/论文/会议摘要）",
        note="建议：将该表作为“动态附件”，每月/每季度更新一次；正式汇报只引用已核验条目。",
    )

    add_bullets_slide(
        prs,
        "附录B：信息来源口径与检索关键词（可核验）",
        bullets=[
            "中国：国家药监局药物临床试验登记与信息公示平台、ChiCTR、公开招股书/年报中的临床登记号。",
            "国际：ClinicalTrials.gov、EU Clinical Trials Register、PubMed/学会年会摘要。",
            "检索词建议：recombinant botulinum toxin A / engineered botulinum neurotoxin / upper limb spasticity / Modified Ashworth Scale / repeat dosing / neutralizing antibody。",
            "记录要素：分子形态、单位/效价方法、剂量与肌群方案、主要终点窗口、复注周期、抗体检测方法与阈值。",
        ],
        subtitle="建议只把“可核验的信息”写进对外汇报；新闻稿只做线索，不做结论",
    )

    return prs


def main() -> None:
    prs = build_deck()
    prs.save(OUTPUT_PPTX)
    print(f"Saved: {OUTPUT_PPTX}")


if __name__ == "__main__":
    main()

