const data = [0.6, 0.8, 1.4, 1.0, 0.7, 0.9, 0.8, 0.5];

const labels = [
  "01/05",
  "02/05",
  "03/05",
  "04/05",
  "05/05",
  "06/05",
  "07/05",
  "08/05",
];

export default function ReadoutChart() {
  const width = 500;
  const height = 220;

  const points = data
    .map((value, index) => {
      const x = (index / (data.length - 1)) * width;

      const y =
        height -
        (value / 2) * height;

      return `${x},${y}`;
    })
    .join(" ");

  const area =
    `0,${height} ` +
    points +
    ` ${width},${height}`;

  return (
    <div style={{ width: "100%" }}>
      <svg
        viewBox={`0 0 ${width} ${height}`}
        style={{ width: "100%", height: "220px" }}
      >
        <polygon
          points={area}
          fill="rgba(245,158,11,0.15)"
        />

        <polyline
          fill="none"
          stroke="#f59e0b"
          strokeWidth="4"
          points={points}
        />
      </svg>

      <div
        style={{
          display: "flex",
          justifyContent: "space-between",
          marginTop: "8px",
          color: "#94a3b8",
          fontSize: "12px",
        }}
      >
        {labels.map(label => (
          <span key={label}>{label}</span>
        ))}
      </div>
    </div>
  );
}