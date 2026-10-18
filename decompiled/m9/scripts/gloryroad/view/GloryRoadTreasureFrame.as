package gloryroad.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.GloryroadManager;
   import mvc.module.gloryroad.GloryRoadModel;
   import mvc.module.gloryroad.GloryRoadRewarCellInfo;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.view.base.PageList;
   import yishi.view.base.TokenAmountItem;
   import yishi.view.tips.MessageTipManager;
   
   public class GloryRoadTreasureFrame extends GloryRoadView
   {
      
      private var _bgBox:ScaleBitmapImage;
      
      private var _bg:Image;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _pageList:PageList;
      
      private var _vBox:VBox;
      
      private var _oneBtn:IconButton;
      
      private var _oneToken:TokenAmountItem;
      
      private var _tenBtn:IconButton;
      
      private var _tenToken:TokenAmountItem;
      
      private var _sendTag:int;
      
      public function GloryRoadTreasureFrame()
      {
         super();
      }
      
      override protected function initView() : void
      {
         titleText = getLanuage("GloryRoadTreasureFrame.initView.title");
         _bgBox = addCreatComponentByStylename("gloryroad.treasureBgBox");
         _bg = addCreatComponentByStylename("gloryroad.treasureFrameBg");
         _scrollPanel = addCreatComponentByStylename("gloryroad.reasureScrollPanel");
         _vBox = new VBox();
         _pageList = creatComponentByStylename("gloryroad.treasurePageList");
         _pageList.updateCompleteHandler = updateCompleteHandler;
         _vBox.addChild(_pageList);
         _scrollPanel.setView(_vBox);
         _oneBtn = addCreatComponentByStylename("gloryroad.treaseOpenOneBtn");
         _oneToken = addCreatComponentByStylename("gloryroad.treaseOpenOneToken");
         _tenBtn = addCreatComponentByStylename("gloryroad.treaseOpentenBtn");
         _tenToken = addCreatComponentByStylename("gloryroad.treaseOpenTenToken");
      }
      
      private function updateCompleteHandler() : void
      {
         _vBox.refreshChildPos();
         _scrollPanel.commitChanges();
         _scrollPanel.invalidateViewport();
      }
      
      public function show() : void
      {
         __refreshView(null);
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      override protected function initEvent() : void
      {
         addEvent(_oneBtn,"click",__clickHanlder);
         addEvent(_tenBtn,"click",__clickHanlder);
         addEvent(GloryroadManager.instance,"GLORY_ROAD_DATA_UPDATE",__refreshView);
         super.initEvent();
      }
      
      override protected function removeEvent() : void
      {
         deleteEvent(_oneBtn,"click",__clickHanlder);
         deleteEvent(_tenBtn,"click",__clickHanlder);
         deleteEvent(GloryroadManager.instance,"GLORY_ROAD_DATA_UPDATE",__refreshView);
         super.removeEvent();
      }
      
      private function __clickHanlder(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc5_:Object = null;
         var _loc4_:String = null;
         var _loc3_:Object = getPay(true);
         if(_loc3_.am == 0)
         {
            MessageTipManager.instance().show(getLanuage("GloryRoadTreasureFrame.clickHanlder.show"));
            return;
         }
         if(param1.target == _oneBtn)
         {
            _sendTag = 2;
            _loc2_ = getLanuage("GloryRoadTreasureFrame.clickHanlder.alert1",_loc3_.re,_loc3_.am);
            LogicUtils.alert(_loc2_,"SIMPLE_ALERT",suerHandler);
         }
         else if(param1.target == _tenBtn)
         {
            _loc5_ = getPay(false);
            _sendTag = GloryroadManager.instance.model.showAfterJumper ? 3 : 5;
            _loc4_ = getLanuage("GloryRoadTreasureFrame.clickHanlder.alert2",_loc5_.re,_loc5_.am);
            LogicUtils.alert(_loc4_,"SIMPLE_ALERT",suerHandler);
         }
      }
      
      private function suerHandler(param1:Boolean, param2:Boolean) : void
      {
         var _loc4_:Object = null;
         var _loc3_:Object = null;
         if(!param1)
         {
            return;
         }
         if(_sendTag == 2)
         {
            _loc4_ = getPay(true);
            if(!LogicUtils.judgePointEnoughToShowPay(_loc4_.re,false))
            {
               return;
            }
         }
         else if(_sendTag == 3)
         {
            _loc3_ = getPay(false);
            if(!LogicUtils.judgePointEnoughToShowPay(_loc3_.re,false))
            {
               return;
            }
         }
         GloryroadManager.instance.openBox(_sendTag);
      }
      
      private function getPay(param1:Boolean) : Object
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = _pageList.data;
         for each(var _loc5_:GloryRoadRewarCellInfo in _loc4_)
         {
            if(_loc5_.isCanOpen)
            {
               _loc3_++;
               _loc2_ += param1 ? _loc5_.onePay : int(_loc5_.allPay);
            }
         }
         return {
            "am":_loc3_,
            "re":_loc2_
         };
      }
      
      private function __refreshView(param1:Event) : void
      {
         if(GloryroadManager.instance.model.canGetBox)
         {
            GloryroadManager.instance.openBox(0);
         }
         var _loc4_:GloryRoadModel = GloryroadManager.instance.model;
         _pageList.data = _loc4_.getTreasureListData();
         _oneToken.firstText = _loc4_.getConfig().openBoxPoint.toString();
         _oneToken.secondText = _loc4_.treasureAllOpenCount + "/10";
         var _loc2_:Object = getPay(false);
         _tenToken.firstText = _loc2_.re.toString();
         var _loc3_:Boolean = false;
         if(_loc4_.showAfterJumper)
         {
            _loc3_ = true;
            _tenBtn.x = 300;
            _tenToken.x = 315;
         }
         else
         {
            _tenBtn.x = 225;
            _tenToken.x = 240;
         }
         _oneBtn.visible = _loc3_;
         _oneToken.visible = _loc3_;
      }
      
      override protected function __frameResponse(param1:FrameEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            GloryroadManager.instance.model.isBuffJumper = false;
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc3_ = LanguageMgr.GetTranslation("GloryRoadTreasureFrame.frameResponse.alert");
            SharedManagerHelper.ins.needAlert("GloryRoadTreasureFrame.close.alert",__frameHandler,_loc2_,_loc3_);
         }
      }
      
      private function __frameHandler() : void
      {
         GloryroadManager.instance.model.viewSate = 0;
         GloryroadManager.instance.dispatchEvent(new NotificationEvent("GLORY_ROAD_DATA_UPDATE"));
         if(GloryroadManager.instance.model.showAfterJumper)
         {
            FrameControllerManager.instance.openControllerByInfo("gloryroad","glory_road_buff");
         }
         dispose();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bgBox);
         _bgBox = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_pageList);
         _pageList = null;
         ObjectUtils.disposeObject(_oneBtn);
         _oneBtn = null;
         ObjectUtils.disposeObject(_oneToken);
         _oneToken = null;
         ObjectUtils.disposeObject(_tenBtn);
         _tenBtn = null;
         ObjectUtils.disposeObject(_tenToken);
         _tenToken = null;
         super.dispose();
      }
   }
}

