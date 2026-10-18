package mvc.controler
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.lordtrial.LordTrialRankInfo;
   import yishi.manager.LordTrialManager;
   import yishi.manager.PathManager;
   
   public class LordTrialController extends FrameController
   {
      
      public static const MAINFRAME:int = 0;
      
      public static const PRAY:int = 2;
      
      public static const RANK:int = 3;
      
      private var _list1:XMLList;
      
      private var _list2:XMLList;
      
      private var _list3:XMLList;
      
      public function LordTrialController()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 2)
         {
            return "lordtrial.LordTrialPrayFrame";
         }
         if(_data.openType == 3)
         {
            return "lordtrial.LordTrialRankFrame";
         }
         if(_data.openType == 0)
         {
            return "lordtrial.LordTrialMainFrame";
         }
         return "lordtrial.LordTrialFrame";
      }
      
      public function loadRankXML() : void
      {
         var _loc2_:String = "lordtrial_unzip.xml";
         var _loc1_:String = PathManager.orderPath + _loc2_;
         LoaderManagerII.instance.load(_loc1_,8,8,__onXMLDataLoaded);
      }
      
      private function __onXMLDataLoaded(param1:LoaderInfo, param2:Object) : void
      {
         var _loc4_:String = param1.url;
         _loc4_ = _loc4_.replace(PathManager.orderPath,"");
         var _loc3_:int = _loc4_.indexOf("?");
         if(_loc3_ != -1)
         {
            _loc4_ = _loc4_.substring(0,_loc3_);
         }
         resolveRankXML(new XML(param2));
      }
      
      public function resolveRankXML(param1:XML) : void
      {
         var _loc2_:XMLList = null;
         var _loc7_:LordTrialRankInfo = null;
         var _loc3_:* = null;
         var _loc4_:XMLList = null;
         var _loc5_:XMLList = null;
         var _loc6_:Vector.<LordTrialRankInfo> = new Vector.<LordTrialRankInfo>();
         if(param1 != null)
         {
            _loc2_ = param1.LordTrialOrder0;
            _list1 = _loc2_.LordTrialOrder;
            for each(_loc3_ in _list1)
            {
               _loc7_ = new LordTrialRankInfo();
               _loc7_.gate = 1;
               _loc7_.isVip = _loc3_.@IsVip;
               _loc7_.layerNum = _loc3_.@Index;
               _loc7_.userName = _loc3_.@NickName;
               _loc7_.rank = _loc3_.@Order;
               _loc6_.push(_loc7_);
            }
            _loc4_ = param1.LordTrialOrder1;
            _list2 = _loc4_.LordTrialOrder;
            for each(_loc3_ in _list2)
            {
               _loc7_ = new LordTrialRankInfo();
               _loc7_.gate = 2;
               _loc7_.isVip = _loc3_.@IsVip;
               _loc7_.layerNum = _loc3_.@Index;
               _loc7_.userName = _loc3_.@NickName;
               _loc7_.rank = _loc3_.@Order;
               _loc6_.push(_loc7_);
            }
            _loc5_ = param1.LordTrialOrder2;
            _list3 = _loc5_.LordTrialOrder;
            for each(_loc3_ in _list3)
            {
               _loc7_ = new LordTrialRankInfo();
               _loc7_.gate = 3;
               _loc7_.isVip = _loc3_.@IsVip;
               _loc7_.layerNum = _loc3_.@Index;
               _loc7_.userName = _loc3_.@NickName;
               _loc7_.rank = _loc3_.@Order;
               _loc6_.push(_loc7_);
            }
         }
         LordTrialManager.instance.model.lordTrialRankData = _loc6_;
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

