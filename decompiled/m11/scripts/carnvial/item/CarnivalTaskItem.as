package carnvial.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.carnival.CarnivalTaskInfo;
   import yishi.datas.templates.CarnivalDailyChallengeTemplateInfo;
   import yishi.manager.CarnivalManager;
   import yishi.manager.TempleteManager;
   
   public class CarnivalTaskItem extends Sprite
   {
      
      private var _taskItemBg:Bitmap;
      
      private var _taskTitleTxt:FilterFrameText;
      
      private var _taskDesTxt:FilterFrameText;
      
      private var _taskScoreTxt:FilterFrameText;
      
      private var _taskGetbtn:BaseButton;
      
      private var _taskGetFlg:Image;
      
      private var _taskBtnIcon:ScaleFrameImage;
      
      private var _data:CarnivalTaskInfo;
      
      private var _tempInfo:CarnivalDailyChallengeTemplateInfo;
      
      public function CarnivalTaskItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _taskItemBg = ComponentFactory.Instance.creatBitmap("asset.carniver.taskItemBg");
         _taskTitleTxt = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.taskTitleTxt");
         _taskDesTxt = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.taskDesTxt");
         _taskScoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.taskScoreTxt");
         _taskGetbtn = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.taskGetbtn");
         _taskGetFlg = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.taskGetFlg");
         _taskBtnIcon = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.taskBtnIcon");
         addChild(_taskItemBg);
         addChild(_taskTitleTxt);
         addChild(_taskDesTxt);
         addChild(_taskScoreTxt);
         addChild(_taskGetbtn);
         addChild(_taskGetFlg);
         _taskGetbtn.addChild(_taskBtnIcon);
      }
      
      private function initEvent() : void
      {
         _taskGetbtn.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         _taskGetbtn.addEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(_tempInfo)
         {
            CarnivalManager.Instance.opRequest(7,_tempInfo.Id);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_taskItemBg);
         _taskItemBg = null;
         ObjectUtils.disposeObject(_taskTitleTxt);
         _taskTitleTxt = null;
         ObjectUtils.disposeObject(_taskDesTxt);
         _taskDesTxt = null;
         ObjectUtils.disposeObject(_taskScoreTxt);
         _taskScoreTxt = null;
         ObjectUtils.disposeObject(_taskGetbtn);
         _taskGetbtn = null;
         ObjectUtils.disposeObject(_taskGetFlg);
         _taskGetFlg = null;
         ObjectUtils.disposeObject(_taskBtnIcon);
         _taskBtnIcon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
         _tempInfo = null;
      }
      
      public function set data(param1:CarnivalTaskInfo) : void
      {
         _data = param1;
         if(_data)
         {
            tempInfo = TempleteManager.instance.carnivalDailyChallengeTemplateCate.getTempInfo(_data.taskId);
            _taskTitleTxt.text = _tempInfo.Title + "(" + _data.data + "/" + _tempInfo.Para1 + ")";
            if(_data.isReward)
            {
               _taskGetFlg.visible = true;
               _taskGetbtn.visible = false;
            }
            else
            {
               _taskGetFlg.visible = false;
               _taskGetbtn.visible = true;
               if(_tempInfo.Para1 <= _data.data)
               {
                  _taskGetbtn.enable = true;
                  _taskBtnIcon.setFrame(1);
               }
               else
               {
                  _taskGetbtn.enable = false;
                  _taskBtnIcon.setFrame(2);
               }
            }
         }
      }
      
      public function set tempInfo(param1:CarnivalDailyChallengeTemplateInfo) : void
      {
         if(_tempInfo)
         {
            return;
         }
         _tempInfo = param1;
         _taskDesTxt.htmlText = _tempInfo.Description;
         _taskScoreTxt.htmlText = LanguageMgr.GetTranslation("carnival.task.score",_tempInfo.Points);
      }
   }
}

