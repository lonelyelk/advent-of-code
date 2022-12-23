# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength
module Nets
  NET1 = {
    -1 + 0i => {
      0 => {
        trans: ->(n, side) { (side + n.imag) + side * 1i },
        rot: -1i,
      },
      1 => {
        trans: ->(n, side) { (5 * side - 1 - n.imag) + (3 * side - 1) * 1i },
        rot: 1i,
      },
      2 => {
        trans: ->(n, side) { (4 * side - 1 - n.imag) + (2 * side - 1) * 1i },
        rot: 1i,
      },
    },
    1 + 0i => {
      0 => {
        trans: ->(n, side) { (4 * side - 1) + (side * 3 - 1 - n.imag) * 1i },
        rot: -1,
      },
      1 => {
        trans: ->(n, side) { (5 * side - 1 - n.imag) + side * 2i },
        rot: 1i,
      },
      2 => {
        trans: ->(n, side) { (3 * side - 1) + (3 * side - 1 - n.imag) * 1i },
        rot: -1,
      },
    },
    -1i => {
      0 => {
        trans: ->(n, side) { (3 * side - 1 - n.real) + 0i },
        rot: -1,
      },
      1 => {
        trans: ->(n, side) { 2 * side + (n.real - side) * 1i },
        rot: 1i,
      },
      2 => {
        trans: ->(n, side) { (3 * side - 1 - n.real) + side * 1i },
        rot: -1,
      },
      3 => {
        trans: ->(n, side) { (3 * side - 1) + (5 * side - 1 - n.real) * 1i },
        rot: -1i,
      },
    },
    1i => {
      0 => {
        trans: ->(n, side) { (3 * side - 1 - n.real) + (3 * side - 1) * 1i },
        rot: -1,
      },
      1 => {
        trans: ->(n, side) { 2 * side + (4 * side - 1 - n.real) * 1i },
        rot: -1i,
      },
      2 => {
        trans: ->(n, side) { (3 * side - 1 - n.real) + (2 * side - 1) * 1i },
        rot: -1,
      },
      3 => {
        trans: ->(n, side) { 0 + (5 * side - 1 - n.real) * 1i },
        rot: -1i,
      },
    },
  }.freeze
  NET2 = {
    -1 + 0i => {
      0 => {
        trans: ->(n, side) { 0 + (3 * side - 1 - n.imag) * 1i },
        rot: -1,
      },
      1 => {
        trans: ->(n, side) { (n.imag - side) + side * 2i },
        rot: -1i,
      },
      2 => {
        trans: ->(n, side) { side + (3 * side - 1 - n.imag) * 1i },
        rot: -1,
      },
      3 => {
        trans: ->(n, side) { (n.imag - 2 * side) + 0i },
        rot: -1i,
      },
    },
    1 + 0i => {
      0 => {
        trans: ->(n, side) { (2 * side - 1) + (3 * side - 1 - n.imag) * 1i },
        rot: -1,
      },
      1 => {
        trans: ->(n, side) { n.imag + side + (side - 1) * 1i },
        rot: -1i,
      },
      2 => {
        trans: ->(n, side) { (3 * side - 1) + (3 * side - 1 - n.imag) * 1i },
        rot: -1,
      },
      3 => {
        trans: ->(n, side) { (n.imag - 2 * side) + (3 * side - 1) * 1i },
        rot: -1i,
      },
    },
    -1i => {
      0 => {
        trans: ->(n, side) { side + (side + n.real) * 1i },
        rot: 1i,
      },
      1 => {
        trans: ->(n, side) { 0 + (n.real + 2 * side) * 1i },
        rot: 1i,
      },
      2 => {
        trans: ->(n, side) { (n.real - 2 * side) + (4 * side - 1) * 1i },
        rot: 1,
      },
    },
    1i => {
      0 => {
        trans: ->(n, side) { (2 * side + n.real) + 0i },
        rot: 1,
      },
      1 => {
        trans: ->(n, side) { (side - 1) + (2 * side + n.real) * 1i },
        rot: 1i,
      },
      2 => {
        trans: ->(n, side) { 2 * side - 1 + (n.real - side) * 1i },
        rot: 1i,
      },
    },
  }.freeze
end
# rubocop:enable Metrics/ModuleLength
