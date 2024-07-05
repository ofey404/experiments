export default function Home() {
  return (
    <div className="container mx-auto my-10 p-10 border">
      <div className="flex flex-wrap space-x-2">
        <button className="btn btn-neutral">Button Neutral</button>
        <button className="btn btn-primary">Button Primary</button>
        <button className="btn btn-secondary">Button Secondary</button>
        <button className="btn btn-accent">Button Accent</button>
        <button className="btn btn-info">Button Info</button>
        <button className="btn btn-success">Button Success</button>
        <button className="btn btn-warning">Button Warning</button>
      </div>
      <table className="table-auto w-full mt-4">
        <thead>
          <tr>
            <th className="px-4 py-2">Button Type</th>
            <th className="px-4 py-2">Example</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td className="border px-4 py-2">Neutral</td>
            <td className="border px-4 py-2"><button className="btn btn-neutral">Button Neutral</button></td>
          </tr>
          <tr>
            <td className="border px-4 py-2">Primary</td>
            <td className="border px-4 py-2"><button className="btn btn-primary">Button Primary</button></td>
          </tr>
          <tr>
            <td className="border px-4 py-2">Secondary</td>
            <td className="border px-4 py-2"><button className="btn btn-secondary">Button Secondary</button></td>
          </tr>
          <tr>
            <td className="border px-4 py-2">Accent</td>
            <td className="border px-4 py-2"><button className="btn btn-accent">Button Accent</button></td>
          </tr>
          <tr>
            <td className="border px-4 py-2">Info</td>
            <td className="border px-4 py-2"><button className="btn btn-info">Button Info</button></td>
          </tr>
          <tr>
            <td className="border px-4 py-2">Success</td>
            <td className="border px-4 py-2"><button className="btn btn-success">Button Success</button></td>
          </tr>
          <tr>
            <td className="border px-4 py-2">Warning</td>
            <td className="border px-4 py-2"><button className="btn btn-warning">Button Warning</button></td>
          </tr>
        </tbody>
      </table>
    </div>
  );
}