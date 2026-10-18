package oldplayerreturn.alliance
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.allianceregression.TaskData;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.OldPlayerReturnTaskTempInfo;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class OldPlayerReturnOracleTaskItem extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _progressTxt:FilterFrameText;
      
      private var _rewardsTxt:FilterFrameText;
      
      private var _hBox:HBox;
      
      private var _btn:IconButton;
      
      private var _receivedBmp:Bitmap;
      
      private var _expTxt:FilterFrameText;
      
      private var _numTxt:FilterFrameText;
      
      private var _data:TaskData;
      
      private var _taskInfo:OldPlayerReturnTaskTempInfo;
      
      public function OldPlayerReturnOracleTaskItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnOracleTaskItem.bg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnOracleTaskItem.titleTxt");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnOracleTaskItem.descTxt");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnOracleTaskItem.progressTxt");
         _rewardsTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnOracleTaskItem.rewardsTxt");
         _hBox = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnOracleTaskItem.hBox");
         _btn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnOracleTaskItem.btn");
         _receivedBmp = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnTaskItem.received");
         _expTxt = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnTaskItem.expTxt");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnTaskItem.numTxt");
         addChild(_bg);
         addChild(_titleTxt);
         addChild(_descTxt);
         addChild(_progressTxt);
         addChild(_rewardsTxt);
         addChild(_hBox);
         addChild(_expTxt);
         addChild(_numTxt);
         addChild(_btn);
         addChild(_receivedBmp);
         _rewardsTxt.text = LanguageMgr.GetTranslation("OldPlayerReturnTaskItem.rewardsTxt.text");
         _expTxt.text = LanguageMgr.GetTranslation("OldPlayerReturnTaskItem.expTxt.text");
         _receivedBmp.x = 341;
         _receivedBmp.y = 60;
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
         if(_btn)
         {
            _btn.addEventListener("click",__btnClickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_btn)
         {
            _btn.removeEventListener("click",__btnClickHandler);
         }
      }
      
      private function __btnClickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         if(!_taskInfo)
         {
            return;
         }
         OldPlayerReturnManager.instance.send(0,_taskInfo.TaskId);
      }
      
      public function set data(param1:TaskData) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         _taskInfo = TempleteManager.instance.oldPlayerReturnTaskTempCate.getTempInfoById(_data.templateId);
         if(!_taskInfo)
         {
            return;
         }
         _titleTxt.text = _taskInfo.TaskTitle;
         var _loc2_:String = _taskInfo.TaskDes;
         _loc2_ = _loc2_.replace("{1}",_taskInfo.Para1.toString());
         _descTxt.text = _loc2_;
         _progressTxt.text = LanguageMgr.GetTranslation("OldPlayerReturnTaskItem.progressTxt.text",_data.currentCount,_taskInfo.Para1);
         _numTxt.text = _taskInfo.TaskCount.toString();
         _hBox.removeAllChild();
         creatRewardsView(_taskInfo.RewardItem1,_taskInfo.RewardItemNum1);
         creatRewardsView(_taskInfo.RewardItem2,_taskInfo.RewardItemNum2);
         creatRewardsView(_taskInfo.RewardItem3,_taskInfo.RewardItemNum3);
         if(_data.status == 0)
         {
            _receivedBmp.visible = false;
            _btn.visible = true;
            _btn.enable = false;
         }
         else if(_data.status == 1)
         {
            _receivedBmp.visible = false;
            _btn.visible = true;
            _btn.enable = true;
         }
         else
         {
            _receivedBmp.visible = true;
            _btn.visible = false;
            _btn.enable = false;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         ObjectUtils.disposeObject(_rewardsTxt);
         _rewardsTxt = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_receivedBmp);
         _receivedBmp = null;
         ObjectUtils.disposeAllChildren(_hBox);
         _hBox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

