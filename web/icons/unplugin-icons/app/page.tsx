import IconAccessibility from '~icons/carbon/accessibility'
import IconAccountBox from '~icons/mdi/account-box'

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">

      <div>
        <IconAccessibility />
        <IconAccountBox style={{ fontSize: '2em', color: 'red' }} />
      </div>
    </main>
  );
}
