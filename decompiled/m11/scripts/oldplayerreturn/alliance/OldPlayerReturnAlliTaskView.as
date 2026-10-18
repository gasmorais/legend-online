package oldplayerreturn.alliance
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.allianceregression.TaskData;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.oldplayerreturn.OldPlayerReturnModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.OldPlayerReturnTaskTempInfo;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   
   public class OldPlayerReturnAlliTaskView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _btn1:SelectedTextButton;
      
      private var _btn2:SelectedTextButton;
      
      private var _btn3:SelectedTextButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _leftImg:Bitmap;
      
      private var _rightImg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _progressTxt:FilterFrameText;
      
      private var _rewardsTxt:FilterFrameText;
      
      private var _hBox:HBox;
      
      private var _receiveBtn:IconButton;
      
      private var _receivedBmp:Bitmap;
      
      private var _expTxt:FilterFrameText;
      
      private var _numTxt:FilterFrameText;
      
      private var _data:TaskData;
      
      private var _taskInfo:OldPlayerReturnTaskTempInfo;
      
      private var _dic:SimpleDictionary = new SimpleDictionary();
      
      public function OldPlayerReturnAlliTaskView()
      {
         super();
         initView();
         addEvent();
         _group.selectIndex = 0;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnAllianceView.rightBg2");
         _btn1 = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnAlliTaskView.btn1");
         _btn2 = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnAlliTaskView.btn2");
         _btn3 = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnAlliTaskView.btn3");
         _leftImg = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnAlliTaskView.leftImg");
         _rightImg = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnAlliTaskView.rightImg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnAlliTaskView.titleTxt");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnAlliTaskView.descTxt");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnAlliTaskView.progressTxt");
         _rewardsTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnAlliTaskView.rewardsTxt");
         _hBox = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnAlliTaskView.hBox");
         _receiveBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnAlliTaskView.receiveBtn");
         _receivedBmp = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnTaskItem.received");
         _expTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnAlliTaskView.expTxt");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnAlliTaskView.numTxt");
         addChild(_bg);
         addChild(_btn1);
         addChild(_btn2);
         addChild(_btn3);
         addChild(_leftImg);
         addChild(_rightImg);
         addChild(_titleTxt);
         addChild(_descTxt);
         addChild(_progressTxt);
         addChild(_rewardsTxt);
         addChild(_hBox);
         addChild(_expTxt);
         addChild(_numTxt);
         addChild(_receiveBtn);
         addChild(_receivedBmp);
         _group = new SelectedButtonGroup();
         _group.addSelectItem(_btn1);
         _group.addSelectItem(_btn2);
         _group.addSelectItem(_btn3);
         _rewardsTxt.text = LanguageMgr.GetTranslation("OldPlayerReturnTaskItem.rewardsTxt.text");
         _expTxt.text = LanguageMgr.GetTranslation("OldPlayerReturnAlliTaskView.expTxt.text");
         _receivedBmp.x = 197;
         _receivedBmp.y = 360;
         _btn1.text = LanguageMgr.GetTranslation("OldPlayerReturnAlliTaskView.btn.text1");
         _btn2.text = LanguageMgr.GetTranslation("OldPlayerReturnAlliTaskView.btn.text2");
         _btn3.text = LanguageMgr.GetTranslation("OldPlayerReturnAlliTaskView.btn.text3");
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
            _loc3_ = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnOracleTaskItem.itemView");
            _loc3_.data = _loc5_;
            _hBox.addChild(_loc3_);
         }
      }
      
      private function addEvent() : void
      {
         _group.addEventListener("change",__groupChangeHandler);
         _receiveBtn.addEventListener("click",__receiveBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _group.removeEventListener("change",__groupChangeHandler);
         _receiveBtn.removeEventListener("click",__receiveBtnClickHandler);
      }
      
      private function __receiveBtnClickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         if(!_taskInfo)
         {
            return;
         }
         OldPlayerReturnManager.instance.send(0,_taskInfo.TaskId,_data.allyId);
      }
      
      private function __groupChangeHandler(param1:Event) : void
      {
         _data = _dic[_group.selectIndex + 1];
         refreshView();
      }
      
      public function refreshView() : void
      {
         if(!_data)
         {
            _titleTxt.text = "";
            _descTxt.text = "";
            _progressTxt.text = "";
            _numTxt.text = "";
            _hBox.removeAllChild();
            _receivedBmp.visible = false;
            _receiveBtn.visible = false;
            _receiveBtn.enable = false;
            return;
         }
         _taskInfo = TempleteManager.instance.oldPlayerReturnTaskTempCate.getTempInfoById(_data.templateId);
         if(!_taskInfo)
         {
            return;
         }
         _titleTxt.text = _taskInfo.TaskTitle;
         var _loc1_:String = _taskInfo.TaskDes;
         _loc1_ = _loc1_.replace("{1}",_taskInfo.Para1.toString());
         _descTxt.text = _loc1_;
         _progressTxt.text = LanguageMgr.GetTranslation("OldPlayerReturnTaskItem.progressTxt.text",_data.currentCount,_taskInfo.Para1);
         _numTxt.text = _taskInfo.TaskCount.toString();
         _hBox.removeAllChild();
         creatRewardsView(_taskInfo.RewardItem1,_taskInfo.RewardItemNum1);
         creatRewardsView(_taskInfo.RewardItem2,_taskInfo.RewardItemNum2);
         creatRewardsView(_taskInfo.RewardItem3,_taskInfo.RewardItemNum3);
         if(_data.status == 0)
         {
            _receivedBmp.visible = false;
            _receiveBtn.visible = true;
            _receiveBtn.enable = false;
         }
         else if(_data.status == 1)
         {
            _receivedBmp.visible = false;
            _receiveBtn.visible = true;
            _receiveBtn.enable = true;
         }
         else
         {
            _receivedBmp.visible = true;
            _receiveBtn.visible = false;
            _receiveBtn.enable = false;
         }
      }
      
      public function refreshAllyId() : void
      {
         var _loc2_:OldPlayerReturnTaskTempInfo = null;
         _dic.clear();
         for each(var _loc1_:TaskData in model.allianceList)
         {
            if(_loc1_.allyId == model.selectedAllyId)
            {
               _loc2_ = TempleteManager.instance.oldPlayerReturnTaskTempCate.getTempInfoById(_loc1_.templateId);
               if(_loc2_)
               {
                  _dic.add(_loc2_.TaskNum,_loc1_);
               }
            }
         }
         _data = _dic[_group.selectIndex + 1];
         refreshView();
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
         ObjectUtils.disposeObject(_btn1);
         _btn1 = null;
         ObjectUtils.disposeObject(_btn2);
         _btn2 = null;
         ObjectUtils.disposeObject(_btn3);
         _btn3 = null;
         ObjectUtils.disposeObject(_leftImg);
         _leftImg = null;
         ObjectUtils.disposeObject(_rightImg);
         _rightImg = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         ObjectUtils.disposeObject(_rewardsTxt);
         _rewardsTxt = null;
         ObjectUtils.disposeObject(_receiveBtn);
         _receiveBtn = null;
         ObjectUtils.disposeObject(_receivedBmp);
         _receivedBmp = null;
         ObjectUtils.disposeAllChildren(_hBox);
         _hBox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

