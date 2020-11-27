// import React...
import React from 'react';
import Firebase from '../firebase';
import 'fullcalendar-reactwrapper/dist/css/fullcalendar.min.css';
import FullCalendar from 'fullcalendar-reactwrapper';

class Calender extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      events: [
        {
          title: 'All Day Event',
          start: '2017-05-01',
        },
      ],
    };
  }

  async componentDidMount() {
    const eventList = await Firebase.firestore()
      .collection('calendar_events')
      .get();
    const finalList = eventList.docs.map((value) => {
      const val = value.data();
      const obj = {
        color: val.color,
        start: val.start_date.toDate(),
        title: val.title,
      };
      return obj;
    });
    this.setState({ events: finalList });
  }

  render() {
    return (
      <div id="example-component">
        <FullCalendar
          id="your-custom-ID"
          header={{
            left: 'prev,next today myCustomButton',
            center: 'title',
            right: 'month,basicWeek,basicDay',
          }}
          defaultDate={Date.now()}
          navLinks={true} // can click day/week names to navigate views
          editable={true}
          eventLimit={true} // allow "more" link when too many events
          events={this.state.events}
        />
      </div>
    );
  }
}

export default Calender;
