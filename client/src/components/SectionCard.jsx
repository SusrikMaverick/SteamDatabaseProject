export function SectionCard({ title, eyebrow, children, actions }) {
  return (
    <section className="section-card">
      <div className="section-card-header">
        <div>
          {eyebrow ? <div className="eyebrow">{eyebrow}</div> : null}
          <h2>{title}</h2>
        </div>
        {actions ? <div>{actions}</div> : null}
      </div>
      {children}
    </section>
  );
}
