package mvc.module.outyard
{
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.OutyardTemplateInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class LandPoint
   {
      
      public static const CASTLE:int = 1;
      
      public static const LANDNODE:int = 2;
      
      public static const CRYSTAL:int = 3;
      
      public static const EXPLORE:int = 4;
      
      public static const TITAN:int = 5;
      
      public static const SHUTTLE:int = 6;
      
      public static const ABYSM:int = 7;
      
      public static const TIMEVORTEX:int = 8;
      
      public var id:int;
      
      public var forceIndex:int;
      
      public var nodeState:int;
      
      public var battleStartTime:Number;
      
      public var battleEndTime:Number;
      
      public var attackForce:int;
      
      public var defenceForce:int;
      
      public var attackCount:int;
      
      public var defenceCount:int;
      
      public function LandPoint()
      {
         super();
      }
      
      private function get template() : OutyardTemplateInfo
      {
         return TempleteManager.instance.outyardTemplateCate.getTemplateByID(id);
      }
      
      public function get leftTime() : String
      {
         var _loc3_:int = 0;
         if(nodeState == 2)
         {
            _loc3_ = battleStartTime / 1000 - playerModel.sysSecond;
         }
         else if(nodeState == 3)
         {
            _loc3_ = battleEndTime / 1000 - playerModel.sysSecond;
         }
         var _loc1_:int = _loc3_ / 60;
         if(_loc1_ <= 0)
         {
            _loc1_ = 0;
         }
         return LanguageMgr.GetTranslation("map.internals.view.frame.FieldInfoView.remainintTimeFrameTextText") + ":" + (int(_loc1_ / 60) <= 0 ? LanguageMgr.GetTranslation("public.needMinutes",_loc1_ % 60) : LanguageMgr.GetTranslation("public.needHM",int(_loc1_ / 60),_loc1_ % 60));
      }
      
      public function get mapId() : int
      {
         return template.MapId;
      }
      
      public function get posX() : int
      {
         return template.PosX;
      }
      
      public function get posY() : int
      {
         return template.PosY;
      }
      
      public function get nodeType() : int
      {
         return template.NodeType;
      }
      
      public function get lineArr() : Array
      {
         return template.NodeLink.split(",");
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
   }
}

