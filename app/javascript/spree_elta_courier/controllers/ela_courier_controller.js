import { Controller } from '@hotwired/stimulus';
import { get } from '@rails/request.js';

export default class extends Controller {
  async printVoucher(event) {
    event.preventDefault();

    if (window.confirm('Are you sure?')) {
      const response = await get(
        `${Spree.adminPath}/elta_courier/${event.params.orderId}/print`,
        {
          responseKind: 'json',
        }
      );

      if (response.ok) {
        const { url } = await response.json;
        window.open(url, '_blank');
      } else {
        const { error } = await response.json;
        console.error('Error creating voucher:', error);
      }
    }
  }
}
