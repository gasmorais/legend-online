package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import mvc.FrameController;
   import mvc.module.sort.SortData;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.view.community.LoadingSceneView;
   
   public class PlayerInfoController extends FrameController
   {
      
      private var dic:Dictionary = new Dictionary(false);
      
      public function PlayerInfoController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "playerinfo.PlayerInfoFrame";
      }
      
      override protected function createFrame() : void
      {
         if(_frame)
         {
            ObjectUtils.disposeObject(_frame);
            _frame = null;
         }
         _frame = ComponentFactory.Instance.creatComponentByStylename(frameClassName);
         if(!_frame.isDie)
         {
            showFrame();
         }
         else
         {
            _frame = null;
         }
         if(_isLoadingLock)
         {
            LoadingSceneView.instance.hide();
         }
         _isLoadingLock = false;
      }
      
      override protected function showFrame() : void
      {
         var _loc5_:String = null;
         var _loc3_:Frame = null;
         var _loc2_:Object = _data.frameData;
         var _loc4_:int = 0;
         var _loc1_:Object = _loc2_.d;
         if(_loc1_ is SortData)
         {
            _loc4_ = (_loc1_ as SortData).army.baseHero.userId;
         }
         else if(_loc1_ is ThaneInfo)
         {
            _loc4_ = (_loc1_ as ThaneInfo).userId;
         }
         else
         {
            _loc4_ = int(_loc1_);
         }
         if(_loc2_.op == 10000)
         {
            _loc5_ = "_" + _loc4_;
         }
         else
         {
            _loc5_ = "" + _loc4_;
         }
         if(dic[_loc5_])
         {
            _loc3_ = dic[_loc5_] as Frame;
            _frame.dispose();
            _frame = _loc3_;
         }
         dic[_loc5_] = _frame;
         dic[_frame] = _loc5_;
         _frame.addEventListener("dispose",__removeKeyHandler);
         if(_loc2_.op == 10000)
         {
            _frame["isCross"] = true;
         }
         else if(_loc2_.op == 9999)
         {
            _frame["showMountBtn"] = false;
         }
         _frame["data"] = _loc2_.d;
         _frame["show"]();
         super.showFrame();
      }
      
      private function __removeKeyHandler(param1:Event) : void
      {
         var _loc2_:Frame = param1.currentTarget as Frame;
         _loc2_.removeEventListener("dispose",__removeKeyHandler);
         var _loc3_:Object = dic[_loc2_];
         delete dic[_loc3_];
         delete dic[_loc2_];
      }
   }
}

