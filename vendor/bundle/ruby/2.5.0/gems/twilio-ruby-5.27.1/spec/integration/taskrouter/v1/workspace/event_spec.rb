##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

require 'spec_helper.rb'

describe 'Event' do
  it "can fetch" do
    @holodeck.mock(Twilio::Response.new(500, ''))

    expect {
      @client.taskrouter.v1.workspaces('WSXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                           .events('EVXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').fetch()
    }.to raise_exception(Twilio::REST::TwilioError)

    values = {}
    expect(
    @holodeck.has_request?(Holodeck::Request.new(
        method: 'get',
        url: 'https://taskrouter.twilio.com/v1/Workspaces/WSXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Events/EVXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
    ))).to eq(true)
  end

  it "receives fetch responses" do
    @holodeck.mock(Twilio::Response.new(
        200,
      %q[
      {
          "account_sid": "ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "actor_sid": "WSaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "actor_type": "workspace",
          "actor_url": "https://taskrouter.twilio.com/v1/Workspaces/WSaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "description": "Worker JustinWorker updated to Idle Activity",
          "event_data": {
              "worker_activity_name": "Offline",
              "worker_activity_sid": "WAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
              "worker_attributes": "{}",
              "worker_name": "JustinWorker",
              "worker_sid": "WKaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
              "worker_time_in_previous_activity": "26",
              "worker_time_in_previous_activity_ms": "26123",
              "workspace_name": "WorkspaceName",
              "workspace_sid": "WSaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
          },
          "event_date": "2015-02-07T00:32:41Z",
          "event_date_ms": 987654321111,
          "event_type": "worker.activity",
          "resource_sid": "WKaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "resource_type": "worker",
          "resource_url": "https://taskrouter.twilio.com/v1/Workspaces/WSaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Workers/WKaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "sid": "EVaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "source": "twilio",
          "source_ip_address": "1.2.3.4",
          "workspace_sid": "WSaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "url": "https://taskrouter.twilio.com/v1/Workspaces/WSaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Events/EVaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
      }
      ]
    ))

    actual = @client.taskrouter.v1.workspaces('WSXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                                  .events('EVXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').fetch()

    expect(actual).to_not eq(nil)
  end

  it "can read" do
    @holodeck.mock(Twilio::Response.new(500, ''))

    expect {
      @client.taskrouter.v1.workspaces('WSXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                           .events.list()
    }.to raise_exception(Twilio::REST::TwilioError)

    values = {}
    expect(
    @holodeck.has_request?(Holodeck::Request.new(
        method: 'get',
        url: 'https://taskrouter.twilio.com/v1/Workspaces/WSXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/Events',
    ))).to eq(true)
  end

  it "receives read_full responses" do
    @holodeck.mock(Twilio::Response.new(
        200,
      %q[
      {
          "events": [
              {
                  "account_sid": "ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "actor_sid": "WSaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "actor_type": "workspace",
                  "actor_url": "https://taskrouter.twilio.com/v1/Workspaces/WSaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "description": "Worker JustinWorker updated to Idle Activity",
                  "event_data": {
                      "worker_activity_name": "Offline",
                      "worker_activity_sid": "WAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                      "worker_attributes": "{}",
                      "worker_name": "JustinWorker",
                      "worker_sid": "WKaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                      "worker_time_in_previous_activity": "26",
                      "worker_time_in_previous_activity_ms": "26123",
                      "workspace_name": "WorkspaceName",
                      "workspace_sid": "WSaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                  },
                  "event_date": "2015-02-07T00:32:41Z",
                  "event_date_ms": 987654321111,
                  "event_type": "worker.activity",
                  "resource_sid": "WKaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "resource_type": "worker",
                  "resource_url": "https://taskrouter.twilio.com/v1/Workspaces/WSaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Workers/WKaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "sid": "EVaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "source": "twilio",
                  "source_ip_address": "1.2.3.4",
                  "workspace_sid": "WSaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  "url": "https://taskrouter.twilio.com/v1/Workspaces/WSaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Events/EVaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
              }
          ],
          "meta": {
              "first_page_url": "https://taskrouter.twilio.com/v1/Workspaces/WSaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Events?TaskQueueSid=WQaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&StartDate=2008-01-02T00%3A00%3A00Z&EndDate=2008-01-03T00%3A00%3A00Z&WorkerSid=WKaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&EventType=reservation.created&TaskSid=WTaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&WorkflowSid=WWaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&ReservationSid=WRaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&PageSize=50&Page=0",
              "key": "events",
              "next_page_url": null,
              "page": 0,
              "page_size": 50,
              "previous_page_url": null,
              "url": "https://taskrouter.twilio.com/v1/Workspaces/WSaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Events?TaskQueueSid=WQaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&StartDate=2008-01-02T00%3A00%3A00Z&EndDate=2008-01-03T00%3A00%3A00Z&WorkerSid=WKaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&EventType=reservation.created&TaskSid=WTaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&WorkflowSid=WWaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&ReservationSid=WRaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&PageSize=50&Page=0"
          }
      }
      ]
    ))

    actual = @client.taskrouter.v1.workspaces('WSXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                                  .events.list()

    expect(actual).to_not eq(nil)
  end

  it "receives read_empty responses" do
    @holodeck.mock(Twilio::Response.new(
        200,
      %q[
      {
          "events": [],
          "meta": {
              "first_page_url": "https://taskrouter.twilio.com/v1/Workspaces/WSaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Events?TaskQueueSid=WQaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&StartDate=2008-01-02T00%3A00%3A00Z&EndDate=2008-01-03T00%3A00%3A00Z&WorkerSid=WKaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&EventType=reservation.created&TaskSid=WTaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&WorkflowSid=WWaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&ReservationSid=WRaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&PageSize=50&Page=0",
              "key": "events",
              "next_page_url": null,
              "page": 0,
              "page_size": 50,
              "previous_page_url": null,
              "url": "https://taskrouter.twilio.com/v1/Workspaces/WSaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Events?TaskQueueSid=WQaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&StartDate=2008-01-02T00%3A00%3A00Z&EndDate=2008-01-03T00%3A00%3A00Z&WorkerSid=WKaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&EventType=reservation.created&TaskSid=WTaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&WorkflowSid=WWaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&ReservationSid=WRaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&PageSize=50&Page=0"
          }
      }
      ]
    ))

    actual = @client.taskrouter.v1.workspaces('WSXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') \
                                  .events.list()

    expect(actual).to_not eq(nil)
  end
end