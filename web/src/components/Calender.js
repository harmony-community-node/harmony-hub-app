// import React...
import React from 'react';
import Firebase from '../firebase';
import 'fullcalendar-reactwrapper/dist/css/fullcalendar.min.css';
import FullCalendar from 'fullcalendar-reactwrapper';
import Modal from './modal';

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
      open: false,
      modelInfo: {},
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
        recurrence_type: val.recurrence_type,
        recurrence_rule: val.recurrence_rule,
      };
      return obj;
    });

    const newlist = [...finalList];

    finalList.reduce((accumulator = [], current, index, array) => {
      if (current.recurrence_type === 'Weekly') {
        const position = current.recurrence_rule.indexOf('COUNT');
        const count = current.recurrence_rule[position + 6];
        let arr = [];
        const date = current.start;
        for (let i = 1; i < count; i++) {
          const newdate = new Date(date.setDate(date.getDate() + 7));
          arr.push({ ...current, start: newdate });
        }
        newlist.push(...arr);
      }
    });
    let newSet = new Set(newlist);
    console.log();
    this.setState({ events: Array.from(newSet) });
  }

  render() {
    console.log(this.state.modelInfo);
    const eventClick = (info) => {
      console.log(info);
      this.setState({ open: !this.state.open, modelInfo: info });
    };
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
          eventClick={eventClick}
        />
        <Modal
          open={this.state.open}
          setOpen={(state) => this.setState({ open: state })}
          modalInfo={this.state.modelInfo}
        />
      </div>
    );
  }
}

export default Calender;
