export default function(sequelize, Sequelize) {
    const Model = sequelize.define('Competition', {
        choosen_formula_id: {
            type: Sequelize.INTEGER(10).UNSIGNED,
            allowNull: false,
            references: {
                model: 'Formula',
                key: 'id'
            }
        },
        date: {
            type: Sequelize.DATEONLY,
            allowNull: false
        },
        name: {
            type: Sequelize.STRING(255),
            allowNull: false
        },
        place: {
            type: Sequelize.STRING(255),
            allowNull: true
        },
        owner: {
            type: Sequelize.STRING(45),
            allowNull: true
        },
        type: {
            type: Sequelize.STRING(10),
            allowNull: false
        },
        locked: {
            type: Sequelize.BOOLEAN,
            allowNull: true,
            defaultValue: '0'
        },
        locked_fighter_list: {
            type: Sequelize.BOOLEAN,
            allowNull: true,
            defaultValue: '0'
        }
    }, {
        tableName: 'Competition'
    })
    
    Model.associate = models => {
        Model.hasMany(models.Fighter, { as: 'fighter_list', foreignKey: 'competition_id' })
        Model.hasMany(models.CompetitionFormula, { as: 'formula_config_list', foreignKey: 'competition_id' })
    }

    return Model
}
