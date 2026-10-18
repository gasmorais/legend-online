package spacetime
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import manager.LanguageMgr;
   import spacetime.view.SpaceTimeFloorItem;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class SpaceTimeFaultShareFrame extends Frame
   {
      
      private var _fback:DisplayObject;
      
      private var _listBox:VBox;
      
      private var _list:Vector.<SpaceTimeFloorItem> = new Vector.<SpaceTimeFloorItem>();
      
      private var _whoTxt:GradientText;
      
      private var _rewardBox:HBox;
      
      private var _rewardList:Vector.<BaseItemView> = new Vector.<BaseItemView>();
      
      public function SpaceTimeFaultShareFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _fback = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _rewardBox = ComponentFactory.Instance.creatComponentByStylename("spacetimefalut.share.RewardHbox");
         _whoTxt = ComponentFactory.Instance.creatComponentByStylename("spacetimefalut.whoTxt");
         _listBox = ComponentFactory.Instance.creatComponentByStylename("spacetimefalut.share.floorVbox");
         addChild(_fback);
         addChild(_rewardBox);
         addChild(_whoTxt);
         addChild(_listBox);
         _fback.width = 310;
         _fback.height = 350;
      }
      
      private function initTopRewards(param1:String) : void
      {
         var _loc5_:Array = null;
         var _loc3_:int = 0;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:GoodsInfo = null;
         var _loc2_:BaseItemView = null;
         var _loc4_:int = 0;
         if(param1 != "" && param1 != null)
         {
            _rewardBox.beginChanges();
            _loc5_ = param1.split(",");
            _loc3_ = int(_loc5_.length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc6_ = _loc5_[_loc4_];
               _loc7_ = _loc6_.split(":");
               _loc8_ = new GoodsInfo();
               _loc8_.templateId = int(_loc7_[0]);
               _loc8_.count = int(_loc7_[1]);
               _loc2_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
               _loc2_.data = _loc8_;
               _rewardBox.addChild(_loc2_);
               _rewardList[_loc4_] = _loc2_;
               _loc4_++;
            }
            _rewardBox.commitChanges();
         }
      }
      
      private function initFloorView(param1:int) : void
      {
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc5_:Array = null;
         var _loc7_:Array = null;
         var _loc6_:int = 0;
         var _loc3_:SpaceTimeFloorItem = null;
         var _loc8_:int = 0;
         if(param1 == 9998)
         {
            _loc4_ = TempleteManager.instance.getSpaceTimeBoxConfigValue(1);
            _loc2_ = TempleteManager.instance.getSpaceTimeBoxCountConfigValue(1);
         }
         else
         {
            _loc4_ = TempleteManager.instance.getSpaceTimeBoxConfigValue(2);
            _loc2_ = TempleteManager.instance.getSpaceTimeBoxCountConfigValue(2);
         }
         if(_loc4_ != null)
         {
            _loc5_ = _loc4_.split("|");
            _loc7_ = _loc2_.split("|");
            _loc6_ = int(_loc5_.length);
            _listBox.beginChanges();
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               _loc3_ = new SpaceTimeFloorItem(_loc8_);
               _loc3_.setInitConfigBox(_loc5_[_loc8_],_loc7_[_loc8_]);
               _loc3_.refreshBoxData(99999);
               _list[_loc8_] = _loc3_;
               _listBox.addChild(_loc3_);
               _loc8_++;
            }
            _listBox.commitChanges();
         }
      }
      
      private function refreshFloorView(param1:Array) : void
      {
         var _loc2_:SpaceTimeFloorItem = null;
         var _loc4_:int = 0;
         var _loc3_:int = int(param1.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _list[_loc4_];
            _loc2_.refreshBoxData(int(param1[_loc4_]));
            _loc4_++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:Array) : void
      {
         var _loc6_:String = null;
         var _loc5_:String = null;
         var _loc4_:Array = null;
         var _loc7_:int = 0;
         var _loc2_:String = null;
         var _loc8_:String = null;
         var _loc3_:Array = null;
         if(param1 != null)
         {
            _loc6_ = param1[0];
            _loc5_ = param1[1];
            _loc4_ = _loc5_.split("|");
            _loc7_ = int(_loc4_[0]);
            _loc2_ = _loc4_[1];
            _loc8_ = _loc4_[2];
            initTopRewards(_loc2_);
            initFloorView(_loc7_);
            if(_loc8_ != null && _loc8_ != "")
            {
               _loc3_ = [];
               _loc3_ = _loc8_.split(",");
               refreshFloorView(_loc3_);
            }
            _whoTxt.text = LanguageMgr.GetTranslation("spacetimefault.shareTitle",_loc6_,getDiffName(_loc7_));
         }
         LayerManager.Instance.addToLayer(this,3,false,true);
         x = StageReferance.stage.mouseX;
         y = StageReferance.stage.mouseY - this.height - 5;
      }
      
      private function getDiffName(param1:int) : String
      {
         var _loc2_:String = "";
         if(param1 == 9998)
         {
            _loc2_ = LanguageMgr.GetTranslation("kingtower.difficulty.common");
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("kingtower.difficulty.nightmare");
         }
         return _loc2_;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_fback);
         _fback = null;
         ObjectUtils.disposeObject(_whoTxt);
         _whoTxt = null;
         for each(var _loc1_:SpaceTimeFloorItem in _list)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _list = null;
         for each(var _loc2_:BaseItemView in _rewardList)
         {
            ObjectUtils.disposeObject(_loc2_);
         }
         _rewardList = null;
         ObjectUtils.disposeObject(_listBox);
         _listBox = null;
         ObjectUtils.disposeObject(_rewardBox);
         _rewardBox = null;
         super.dispose();
      }
   }
}

