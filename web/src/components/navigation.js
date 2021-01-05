import React, { lazy, Suspense } from 'react';
import PropTypes from 'prop-types';
import { makeStyles } from '@material-ui/core/styles';
import AppBar from '@material-ui/core/AppBar';
import Tabs from '@material-ui/core/Tabs';
import Tab from '@material-ui/core/Tab';
import Typography from '@material-ui/core/Typography';
import Box from '@material-ui/core/Box';
import ReactDOMServer from 'react-dom/server';
import Loader from './loader';
const Medium = lazy(() => import('./medium/wrapper'));
const Calender = lazy(() => import('./Calender'));
const List = lazy(() => import('./list/list'));
const YouTube = lazy(() => import('./youtube/youtubeWrapper'));

function TabPanel(props) {
  const { children, value, index, ...other } = props;

  return (
    <div
      role="tabpanel"
      hidden={value !== index}
      id={`simple-tabpanel-${index}`}
      aria-labelledby={`simple-tab-${index}`}
      {...other}
    >
      {value === index && (
        <Box p={3}>
          <Typography>{children}</Typography>
        </Box>
      )}
    </div>
  );
}

TabPanel.propTypes = {
  children: PropTypes.node,
  index: PropTypes.any.isRequired,
  value: PropTypes.any.isRequired,
};

function a11yProps(index) {
  return {
    id: `simple-tab-${index}`,
    'aria-controls': `simple-tabpanel-${index}`,
  };
}

const useStyles = makeStyles((theme) => ({
  root: {
    flexGrow: 1,
    backgroundColor: '#fff',
    width: '100px',
    overflow: 'scroll',
  },
}));

export default function SimpleTabs() {
  const classes = useStyles();
  const [value, setValue] = React.useState(0);

  const handleChange = (event, newValue) => {
    setValue(newValue);
  };
  const now = new Date();
  const loader = ReactDOMServer.renderToStaticMarkup(<Loader />);

  console.log(loader);
  return (
    <div className={classes.root}>
      <AppBar position="static">
        <Tabs
          value={value}
          onChange={handleChange}
          aria-label="simple tabs example"
          variant="fullWidth"
        >
          <Tab label="Articles" {...a11yProps(0)} />
          <Tab label="Calendar" {...a11yProps(1)} />
          <Tab label="Youtube" {...a11yProps(2)} />
          <Tab label="Harmony Links" {...a11yProps(3)} />
        </Tabs>
      </AppBar>

      <TabPanel value={value} index={0}>
        <Suspense
          fallback={<div dangerouslySetInnerHTML={{ __html: loader }} />}
        >
          <Medium />
        </Suspense>
      </TabPanel>
      <TabPanel value={value} index={1}>
        <Suspense
          fallback={<div dangerouslySetInnerHTML={{ __html: loader }} />}
        >
          <Calender />
        </Suspense>
      </TabPanel>
      <TabPanel value={value} index={2}>
        <Suspense
          fallback={<div dangerouslySetInnerHTML={{ __html: loader }} />}
        >
          <YouTube />
        </Suspense>
      </TabPanel>
      <TabPanel value={value} index={3}>
        <Suspense
          fallback={<div dangerouslySetInnerHTML={{ __html: loader }} />}
        >
          <List />
        </Suspense>
      </TabPanel>
    </div>
  );
}
