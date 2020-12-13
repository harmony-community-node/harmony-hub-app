import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import Modal from '@material-ui/core/Modal';
import Backdrop from '@material-ui/core/Backdrop';
import Fade from '@material-ui/core/Fade';

const useStyles = makeStyles((theme) => ({
  modal: {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
  },
  paper: {
    backgroundColor: theme.palette.background.paper,
    border: '2px solid #000',
    boxShadow: theme.shadows[5],
    padding: theme.spacing(2, 4, 3),
  },
}));

export default function TransitionsModal({ open, setOpen, modalInfo }) {
  const classes = useStyles();
  console.log(modalInfo, open);

  const handleOpen = () => {
    console.log('djsanda');
    setOpen(true);
  };

  const handleClose = () => {
    console.log('close');
    setOpen(false);
  };

  return (
    <div>
      <button type="button" onClick={handleOpen}>
        react-transition-group
      </button>
      <Modal
        aria-labelledby="transition-modal-title"
        aria-describedby="transition-modal-description"
        className={classes.modal}
        open={open}
        onClose={handleClose}
        closeAfterTransition
        BackdropComponent={Backdrop}
        BackdropProps={{
          timeout: 500,
        }}
      >
        <Fade in={open}>
          <div className={classes.paper}>
            <h4 id="transition-modal-title">Description</h4>
            <p id="transition-modal-description">
              All Day:{' '}
              {modalInfo.allDay === true ? <span>Yes</span> : <span>No</span>}
              <br />
              Description: {modalInfo.title}
              <br />
              Notes: {modalInfo.notes || <span>No Notes regarding this</span>}
              <br />
              StartTime:{' '}
              {modalInfo.start ? modalInfo.start.toDate().toString() : <></>}
              <br />
              EndTime:{' '}
              {modalInfo.end ? modalInfo.end.toDate().toString() : <></>}
              <br />
              Type: {modalInfo.recurrence_type}
            </p>
          </div>
        </Fade>
      </Modal>
    </div>
  );
}
