import React from 'react';
import {View} from 'react-native';
import {workoutSetsByIdSelector} from '../../selectors/workout_sets';
import {connect} from 'react-redux';
import WorkoutSetsForm from './WorkoutSetsForm';
import {globalStyles} from '../../constants/styles';

@connect(state => ({workoutSetsById: workoutSetsByIdSelector(state)}))
export class WorkoutSetsEditScreen extends React.Component {

  static propTypes = {
    navigation: React.PropTypes.shape({
      goBack: React.PropTypes.func.isRequired,
      state: React.PropTypes.object.isRequired
    }).isRequired
  };

  render() {
    const ws = this.props.workoutSetsById[this.props.navigation.state.params.resourceId];

    return (
      <View style={globalStyles.flexContainer}>
        <WorkoutSetsForm
          updatedResource={ws}
          postSubmit={() => this.props.navigation.goBack()}
          exercise_uuid={ws.exercise_uuid}
        />
      </View>

    );
  }
}
