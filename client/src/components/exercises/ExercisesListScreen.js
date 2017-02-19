import React from 'react';
import {View, Button, StyleSheet} from 'react-native';
import {ExercisesList} from './ExercisesList';
import {globalStyles} from '../../constants/styles';

export class ExercisesListScreen extends React.Component {

  static propTypes = {
    navigation: React.PropTypes.shape({
      navigate: React.PropTypes.func.isRequired,
      state: React.PropTypes.object.isRequired
    }).isRequired
  };

  isEdit = () => this.props.navigation.state.params && this.props.navigation.state.params.edit;

  onRowPress = (row) => {
    if (this.isEdit()) {
      this.props.navigation.navigate('ExercisesEdit', {resourceId: row.uuid});
    } else {
      this.props.navigation.navigate('WorkoutSetsAdd', {exercise_uuid: row.uuid});
    }
  };

  render() {
    return (
      <View style={globalStyles.flexContainer}>
        {
          this.isEdit() &&
          <Button
            title="Add"
            onPress={() => this.props.navigation.navigate('ExercisesAdd')}
          />
        }
        <ExercisesList
          onRowPress={this.onRowPress}
        />
      </View>
    );
  }
}