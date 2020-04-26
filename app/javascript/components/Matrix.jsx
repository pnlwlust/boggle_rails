import React from "react";
import Table from 'react-bootstrap/Table';

class Matrix extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            matrixList: this.props.matrixData
        };
    };

    render() {
        return (
            <React.Fragment>
                <div>
                <Table bordered hover>
                    <tbody>
                    {this.props.matrixData.map((list, i) => (
                        <tr key={i}>
                            {list.map((item, j)=>(
                                <td key={j}>{item}</td>
                            ))
                            }
                        </tr>
                    ))}
                    </tbody>
                </Table>
                    {this.props.matrixData}
                </div>
            </React.Fragment>
        );
    }
}

export default Matrix;