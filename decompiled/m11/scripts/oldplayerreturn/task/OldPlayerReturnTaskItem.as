package oldplayerreturn.task
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.allianceregression.TaskData;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.templates.OldPlayerReturnTaskTempInfo;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.manager.TempleteManager;
   
   public class OldPlayerReturnTaskItem extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _progressTxt:FilterFrameText;
      
      private var _rewardTxt:FilterFrameText;
      
      private var _numTxt:FilterFrameText;
      
      private var _btn:IconButton;
      
      private var _receivedBmp:Bitmap;
      
      private var _data:TaskData;
      
      private var _taskInfo:OldPlayerReturnTaskTempInfo;
      
      public function OldPlayerReturnTaskItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnTaskItem.bg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnTaskItem.titleTxt");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnTaskItem.descTxt");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnTaskItem.progressTxt");
         _rewardTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnTaskItem.rewardTxt");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnTaskItem.numTxt");
         _btn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnTaskItem.btn");
         _receivedBmp = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnTaskItem.received");
         addChild(_bg);
         addChild(_titleTxt);
         addChild(_descTxt);
         addChild(_progressTxt);
         addChild(_rewardTxt);
         addChild(_numTxt);
         addChild(_btn);
         addChild(_receivedBmp);
         _rewardTxt.text = LanguageMgr.GetTranslation("OldPlayerReturnTaskItem.rewardTxt.text");
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
         ObjectUtils.disposeObject(_rewardTxt);
         _rewardTxt = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_receivedBmp);
         _receivedBmp = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

