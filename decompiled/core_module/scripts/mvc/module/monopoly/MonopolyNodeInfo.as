package mvc.module.monopoly
{
   import map.internals.data.CampaignNode;
   import map.internals.data.PhysicInfo;
   
   public class MonopolyNodeInfo
   {
      
      public var position:int;
      
      public var type:int;
      
      public var templateId:int;
      
      public var x:int;
      
      public var y:int;
      
      public var nodeId:int;
      
      public var campaignNode:CampaignNode;
      
      public var physicInfo:PhysicInfo;
      
      public function MonopolyNodeInfo()
      {
         super();
      }
      
      public function get sonType() : int
      {
         var _loc1_:int = 2268;
         switch(templateId)
         {
            case 9551:
            case 9601:
            case 9651:
            case 9701:
            case 9751:
            case 9801:
               _loc1_ = 2268;
               break;
            case 9552:
            case 9602:
            case 9652:
            case 9702:
            case 9752:
            case 9802:
               _loc1_ = 2269;
               break;
            case 9553:
            case 9603:
            case 9653:
            case 9703:
            case 9753:
            case 9803:
               _loc1_ = 2270;
               break;
            case 9554:
            case 9604:
            case 9654:
            case 9704:
            case 9754:
            case 9804:
               _loc1_ = 2271;
               break;
            case 9555:
            case 9605:
            case 9655:
            case 9705:
            case 9755:
            case 9805:
               _loc1_ = 2409;
               break;
            case 9556:
            case 9606:
            case 9656:
            case 9706:
            case 9756:
            case 9806:
               _loc1_ = 2198;
         }
         return _loc1_;
      }
   }
}

