import React from 'react';
import ${1}, { Props } from '../components/${2}';

export default {
  title: 'Components/$1',
  component: $1,
  parameters: {
    design: {
      type: 'figma',
      url: '',
    },
  },
  argTypes: {
  },
};

function Template(args : Props) {
  return <$1 {...args} />;
}

export const ${3} = Template.bind({});
$3.args = {
  ${0}
};
