package map.campaign.data
{
   import flash.utils.Dictionary;
   
   public class CollectionRobotData
   {
      
      private static var _robotData:Dictionary;
      
      public function CollectionRobotData()
      {
         super();
      }
      
      private static function setup() : void
      {
         _robotData = new Dictionary(true);
         _robotData[7001] = {
            "body":"warrior_body023",
            "army":"warrior_arms002",
            "job":1,
            "sex":0
         };
         _robotData[7002] = {
            "body":"warrior_body023",
            "army":"warrior_arms002",
            "job":1,
            "sex":0
         };
         _robotData[7003] = {
            "body":"warrior_body023",
            "army":"warrior_arms002",
            "job":1,
            "sex":0
         };
         _robotData[7004] = {
            "body":"warrior_body023",
            "army":"warrior_arms002",
            "job":1,
            "sex":0
         };
         _robotData[7005] = {
            "body":"warrior_body023",
            "army":"warrior_arms002",
            "job":1,
            "sex":1
         };
         _robotData[7006] = {
            "body":"warrior_body023",
            "army":"warrior_arms002",
            "job":1,
            "sex":1
         };
         _robotData[7007] = {
            "body":"warrior_body023",
            "army":"warrior_arms002",
            "job":1,
            "sex":1
         };
         _robotData[7008] = {
            "body":"warrior_body023",
            "army":"warrior_arms002",
            "job":1,
            "sex":1
         };
      }
      
      public static function get robotData() : Dictionary
      {
         if(!_robotData)
         {
            setup();
         }
         return _robotData;
      }
   }
}

