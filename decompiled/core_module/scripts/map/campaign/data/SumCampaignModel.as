package map.campaign.data
{
   import com.road.yishi.proto.sumpassion.SumCampaignTaskListMsg;
   
   public class SumCampaignModel
   {
      
      private var _sumCampaignTaskListMsg:SumCampaignTaskListMsg;
      
      public function SumCampaignModel()
      {
         super();
      }
      
      public function set sumTaskListMsg(param1:SumCampaignTaskListMsg) : void
      {
         _sumCampaignTaskListMsg = param1;
      }
      
      public function get sumTaskListMsg() : SumCampaignTaskListMsg
      {
         return _sumCampaignTaskListMsg;
      }
   }
}

