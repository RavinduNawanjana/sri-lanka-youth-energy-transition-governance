# Sri Lanka youth energy-transition governance: evidence-led monitoring

**Independent, reproducible governance research**, Ravindu Nawanjana.

> **Important:** Activity-register examples represent plans, not verified delivery. Some original 2026 documents use conflicting retrospective and prospective language. The code refuses to mark an activity **completed_verified** without an evidence locator and dated completion record.

**Workflow:** R · Quarto. Reusable R functions; defined input contract and empty-data handling; tests in base R; Quarto narrative report; GitHub Actions testing and rendering.

## Source and evidentiary status

`Commonwealth Sustainable Energy Transition (CSET) Youth Sri Lanka Chapter Strategic Roadmap 2026-2030.docx`, `National Youth Capacity Building Workshops on Sustainable Energy.docx`, `Sustainable Energy Youth Technical Committee .docx`.

**Unresolved:** Future-oriented workshop funding requests conflict with retrospective completion language. No interview or workshop attendance lists, confirmations or completed activity dates were supplied; the illustrative registry is not evidence that implementation occurred.

## Run

Install R (4.3+) and [Quarto](https://quarto.org/), then run at the project root:

```sh
Rscript tests/test_indicators.R
Rscript scripts/run_all.R
quarto render
```

`outputs/` contains programme-state tables generated from illustrative **proposals only**. A new record must have a verifiable provenance and date before it is promoted to *completed_verified*.

## Evidence-to-code crosswalk

The [claim-level evidence crosswalk](docs/EVIDENCE_CROSSWALK.csv) maps individual statements in the source materials to their status, how the code treats them, and what primary evidence would be required to upgrade them. **Draft source statements are not independently verified facts.**

## Research materials

- [Source register](docs/SOURCE_REGISTER.md)
- [Data dictionary](docs/DATA_DICTIONARY.md)
- [Reproducibility guide](docs/REPRODUCIBILITY.md)
- [Methods](reports/methods.qmd)
- [Evaluation and publication limits](reports/limitations.qmd)
- [Rights and ethics](RIGHTS_AND_USE.md)

The repository is an independently authored research companion, not a claim that an organisation formally commissioned, endorsed, or implemented the activities. No blanket open-source licence has been assigned.
