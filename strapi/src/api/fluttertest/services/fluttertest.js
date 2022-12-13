'use strict';

/**
 * fluttertest service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::fluttertest.fluttertest');
