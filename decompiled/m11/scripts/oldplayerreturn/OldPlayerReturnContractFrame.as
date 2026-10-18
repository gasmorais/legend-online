package oldplayerreturn
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.allianceregression.AllyData;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.oldplayerreturn.OldPlayerReturnModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.OldPlayerReturnPrivilegeTempInfo;
   import yishi.datas.templates.OldPlayerReturnRewardTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.manager.TempleteManager;
   import yishi.view.base.ProgressPanel;
   import yishi.view.community.BaseItemView;
   
   public class OldPlayerReturnContractFrame extends Frame implements IManualSize
   {
      
      private var _bg:Bitmap;
      
      private var _levelTxt:FilterFrameText;
      
      private var _levelNumTxt:FilterFrameText;
      
      private var _progress:ProgressPanel;
      
      private var _rewardsBtn:SelectedIconButton;
      
      private var _buffBtn:SelectedIconButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _leftImg:Bitmap;
      
      private var _rightImg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _leftBtn:BaseButton;
      
      private var _rightBtn:BaseButton;
      
      private var _list:SimpleTileList;
      
      private var _receiveBtn:IconButton;
      
      private var _receivedBmp:Bitmap;
      
      private var _spanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _index:int = 0;
      
      public function OldPlayerReturnContractFrame()
      {
         super();
         initView();
         addEvent();
         _group.selectIndex = 0;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,703,538);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("OldPlayerReturnContractFrame.titleText.text");
         _bg = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnContractFrame.bg");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnContractFrame.levelTxt");
         _levelNumTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnContractFrame.levelNumTxt");
         _progress = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnContractFrame.progress");
         _rewardsBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnContractFrame.rewardsBtn");
         _buffBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnContractFrame.buffBtn");
         _leftImg = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnAlliTaskView.leftImg");
         _rightImg = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnAlliTaskView.rightImg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnContractFrame.titleTxt");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnContractFrame.gradeTxt");
         _leftBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnTaskView.leftBtn");
         _rightBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnTaskView.rightBtn");
         _list = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnContractFrame.list",[3]);
         _receiveBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnContractFrame.receiveBtn");
         _receivedBmp = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnTaskItem.received");
         _spanel = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnContractFrame.bossSpanel");
         _vBox = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnContractFrame.vBox");
         addToContent(_bg);
         addToContent(_levelTxt);
         addToContent(_levelNumTxt);
         addToContent(_progress);
         addToContent(_rewardsBtn);
         addToContent(_buffBtn);
         addToContent(_leftImg);
         addToContent(_rightImg);
         addToContent(_titleTxt);
         addToContent(_gradeTxt);
         addToContent(_leftBtn);
         addToContent(_rightBtn);
         addToContent(_list);
         addToContent(_receiveBtn);
         addToContent(_receivedBmp);
         addToContent(_spanel);
         _spanel.setView(_vBox);
         _levelTxt.text = LanguageMgr.GetTranslation("OldPlayerReturnContractFrame.levelTxt.text");
         _progress.initView("oldPlayerReturnContractView.proBack","oldPlayerReturnContractView.proBar","oldPlayerReturnContractView.proTxt");
         _progress.barPosxy(4,4);
         _group = new SelectedButtonGroup();
         _group.addSelectItem(_rewardsBtn);
         _group.addSelectItem(_buffBtn);
         _leftImg.x = 160;
         _leftImg.y = 133;
         _rightImg.x = 450;
         _rightImg.y = 133;
         _leftBtn.x = 54;
         _leftBtn.y = 206;
         _rightBtn.x = 629;
         _rightBtn.y = 206;
         _index = data.contractLevel;
         _receivedBmp.x = 300;
         _receivedBmp.y = 373;
      }
      
      private function creatRewardsView(param1:int, param2:int) : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc3_:BaseItemView = null;
         var _loc4_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
         if(_loc4_)
         {
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = param1;
            _loc5_.count = param2;
            _loc3_ = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnContractFrame.itemView");
            _loc3_.data = _loc5_;
            _list.addChild(_loc3_);
         }
      }
      
      private function refreshBuffItem(param1:Array) : void
      {
         var _loc2_:OldPlayerReturnBuffItem = null;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:OldPlayerReturnPrivilegeTempInfo = null;
         _vBox.removeAllChild();
         _vBox.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = param1[_loc4_];
            if(!(_loc5_ && _loc5_.PrivilegeValue == 0))
            {
               _loc2_ = new OldPlayerReturnBuffItem();
               _loc2_.data = _loc5_;
               _vBox.addChild(_loc2_);
            }
            _loc4_++;
         }
         _vBox.commitChanges();
         _spanel.invalidateViewport();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _group.addEventListener("change",__groupChangeHandler);
         _leftBtn.addEventListener("click",__btnClickHandler);
         _rightBtn.addEventListener("click",__btnClickHandler);
         _receiveBtn.addEventListener("click",__receiveBtnClickHandler);
         NotificationManager.instance.addEventListener("USER_DATA_EVENT",__userDataUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _group.removeEventListener("change",__groupChangeHandler);
         _leftBtn.removeEventListener("click",__btnClickHandler);
         _rightBtn.removeEventListener("click",__btnClickHandler);
         _receiveBtn.removeEventListener("click",__receiveBtnClickHandler);
         NotificationManager.instance.removeEventListener("USER_DATA_EVENT",__userDataUpdateHandler);
      }
      
      private function __userDataUpdateHandler(param1:NotificationEvent) : void
      {
         refreshView();
      }
      
      private function __receiveBtnClickHandler(param1:MouseEvent) : void
      {
         OldPlayerReturnManager.instance.send(6,_index);
      }
      
      private function __btnClickHandler(param1:MouseEvent) : void
      {
         if(param1.currentTarget == _leftBtn && _index > 1)
         {
            _index = _index - 1;
         }
         else if(param1.currentTarget == _rightBtn && _index < max)
         {
            _index = _index + 1;
         }
         refreshView();
      }
      
      private function __groupChangeHandler(param1:Event) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc5_:OldPlayerReturnRewardTempInfo = null;
         var _loc1_:Array = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:Array = null;
         _leftBtn.enable = _index != 1;
         _rightBtn.enable = _index != max;
         _titleTxt.text = LanguageMgr.GetTranslation("OldPlayerReturnContractFrame.titleTxt.text" + _group.selectIndex);
         if(!data)
         {
            return;
         }
         _levelNumTxt.text = LanguageMgr.GetTranslation("public.level2",data.contractLevel);
         _progress.progressValue(data.contractCurExp,data.contractNeedExp);
         _gradeTxt.text = _index.toString();
         if(_group.selectIndex == 0)
         {
            _list.visible = true;
            _list.removeAllChild();
            _spanel.visible = false;
            _loc5_ = TempleteManager.instance.oldPlayerReturnRewardTempCate.getTempInfoByType(4,_index);
            creatRewardsView(_loc5_.RewardItem1,_loc5_.RewardItemNum1);
            creatRewardsView(_loc5_.RewardItem2,_loc5_.RewardItemNum2);
            creatRewardsView(_loc5_.RewardItem3,_loc5_.RewardItemNum3);
            creatRewardsView(_loc5_.RewardItem4,_loc5_.RewardItemNum4);
            creatRewardsView(_loc5_.RewardItem5,_loc5_.RewardItemNum5);
            creatRewardsView(_loc5_.RewardItem6,_loc5_.RewardItemNum6);
            _loc1_ = data.privilegeProcess.split("|");
            _loc3_ = int(_loc1_[_index - 1]);
            if(_loc3_ == 0)
            {
               _loc2_ = int(model.isReturnPlayer ? data.contractLevel : int(model.allyMaxLevel));
               if(_index <= _loc2_)
               {
                  _receiveBtn.visible = true;
                  _receiveBtn.enable = true;
                  _receivedBmp.visible = false;
               }
               else
               {
                  _receiveBtn.visible = true;
                  _receiveBtn.enable = false;
                  _receivedBmp.visible = false;
               }
            }
            else if(_loc3_ == 1)
            {
               _receiveBtn.visible = false;
               _receivedBmp.visible = true;
            }
         }
         else
         {
            _list.visible = false;
            _receiveBtn.visible = false;
            _receivedBmp.visible = false;
            _spanel.visible = true;
            _loc4_ = TempleteManager.instance.oldPlayerReturnPrivilegeTempCate.getArrByTypeLevel(model.type,_index);
            refreshBuffItem(_loc4_);
         }
      }
      
      public function get max() : int
      {
         return TempleteManager.instance.oldPlayerReturnRewardTempCate.getCountByType(4);
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get data() : AllyData
      {
         return model.selectedAllydata;
      }
      
      private function get model() : OldPlayerReturnModel
      {
         return OldPlayerReturnManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_levelNumTxt);
         _levelNumTxt = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_rewardsBtn);
         _rewardsBtn = null;
         ObjectUtils.disposeObject(_buffBtn);
         _buffBtn = null;
         ObjectUtils.disposeObject(_leftImg);
         _leftImg = null;
         ObjectUtils.disposeObject(_rightImg);
         _rightImg = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_gradeTxt);
         _gradeTxt = null;
         ObjectUtils.disposeObject(_leftBtn);
         _leftBtn = null;
         ObjectUtils.disposeObject(_rightBtn);
         _rightBtn = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeObject(_receiveBtn);
         _receiveBtn = null;
         for each(var _loc1_:BaseItemView in _list)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         for each(var _loc2_:OldPlayerReturnBuffItem in _vBox)
         {
            ObjectUtils.disposeObject(_loc2_);
            _loc2_ = null;
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

