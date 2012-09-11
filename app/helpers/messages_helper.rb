module MessagesHelper
  def why_limit_length_link
    link_to "Why?", "#", data: {
      behavior: 'popover',
      title: 'Why keep updates short?',
      content: '<ul>
          <li>Long updates are a sign that a more thorough conversation is required.</li>
          <li>Updates may be read over the phone, and long updates are hard to follow!</li>
          <li>Updates are designed to be sent frequently.</li>
        </ul>',
      placement: 'top'
    }
  end
end