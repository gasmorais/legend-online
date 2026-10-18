package guidetask
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.guidetask.SimpleTaskInfo;
   import yishi.SwitchPageHelp;
   import yishi.datas.consant.GuideTaskType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.SimpleTaskTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   
   public class GuideTaskItem extends Sprite implements Disposeable, ISelectable
   {
      
      private var _itemBack:Scale9CornerImage;
      
      private var _line:MutipleImage;
      
      private var _icon:ScaleFrameImage;
      
      private var _taskDescTxt:FilterFrameText;
      
      private var _openLvTxt:FilterFrameText;
      
      private var _isCompleteImg:Bitmap;
      
      private var _taskFalgTxt:FilterFrameText;
      
      private var _data:SimpleTaskInfo;
      
      private var _itemSelected:Boolean;
      
      private var _hitSprite:Sprite;
      
      private var _hitTxtSprite:Sprite;
      
      private var _info:SimpleTaskTempInfo;
      
      public function GuideTaskItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _itemBack = ComponentFactory.Instance.creatComponentByStylename("guidetask.selectedHightline.image");
         _line = ComponentFactory.Instance.creatComponentByStylename("guidetask.itemline");
         _icon = ComponentFactory.Instance.creatComponentByStylename("guidetask.taskTypeIcon");
         _taskDescTxt = ComponentFactory.Instance.creatComponentByStylename("guidetask.taskDescTxt");
         _openLvTxt = ComponentFactory.Instance.creatComponentByStylename("guidetask.openLvTxt");
         _isCompleteImg = ComponentFactory.Instance.creatBitmap("asset.guidetask.completeFalg");
         _taskFalgTxt = ComponentFactory.Instance.creatComponentByStylename("guidetask.taskFlagTxt");
         addChild(_line);
         _hitSprite = new Sprite();
         setJoinHitArea();
         addChild(_hitSprite);
         addChild(_itemBack);
         addChild(_icon);
         addChild(_taskDescTxt);
         addChild(_openLvTxt);
         addChild(_isCompleteImg);
         addChild(_taskFalgTxt);
      }
      
      private function initEvent() : void
      {
         addEventListener("click",mouseClickHandler);
      }
      
      public function set data(param1:SimpleTaskInfo) : void
      {
         if(_hitTxtSprite)
         {
            _hitTxtSprite.removeEventListener("click",__hitTxtSpriteHandler);
            if(getChildIndex(_hitTxtSprite) >= 0)
            {
               _hitTxtSprite.graphics.clear();
               _hitTxtSprite = null;
            }
         }
         _itemBack.visible = false;
         _icon.visible = false;
         _taskDescTxt.visible = false;
         _openLvTxt.visible = false;
         _isCompleteImg.visible = false;
         _taskFalgTxt.visible = false;
         if(!param1)
         {
            return;
         }
         _data = param1;
         _itemBack.visible = false;
         _info = TempleteManager.instance.simpleTaskTemplateCate.getSimpleTaskTemp(_data.taskId);
         _icon.setFrame(_info.Type);
         _icon.visible = true;
         var _loc2_:String = _info.Detail;
         _loc2_ = _loc2_.replace("{0}",_info.IParam1);
         _loc2_ = _loc2_.replace("{1}",_info.IParam2);
         _loc2_ = _loc2_.replace("{2}",_info.IParam3);
         _loc2_ = _loc2_.replace("{3}",_info.IParam4);
         _taskDescTxt.text = _loc2_;
         _taskDescTxt.visible = true;
         if(_taskDescTxt.numLines == 1)
         {
            _taskDescTxt.y = 15;
            _taskDescTxt.height = 20;
         }
         else
         {
            _taskDescTxt.y = 0;
            _taskDescTxt.height = 40;
         }
         if(thaneInfo.grades < _info.IParam5)
         {
            _openLvTxt.visible = true;
            _openLvTxt.text = LanguageMgr.GetTranslation("guidetask.GuideTaskItem.openLvTxt.text",_info.IParam5);
         }
         else
         {
            _openLvTxt.visible = false;
            _openLvTxt.text = "";
         }
         _taskFalgTxt.visible = true;
         if(_data.isComplete > 0)
         {
            _taskFalgTxt.text = LanguageMgr.GetTranslation("guidetask.GuideTaskItem.taskFalgTxt.text01");
            _taskFalgTxt.setFrame(2);
            _isCompleteImg.visible = true;
            if(_hitTxtSprite)
            {
               _hitTxtSprite.removeEventListener("click",__hitTxtSpriteHandler);
               if(getChildIndex(_hitTxtSprite) >= 0)
               {
                  removeChild(_hitTxtSprite);
                  _hitTxtSprite.graphics.clear();
                  _hitTxtSprite = null;
               }
            }
         }
         else if(_data.isShow)
         {
            _taskFalgTxt.text = LanguageMgr.GetTranslation("guidetask.GuideTaskItem.taskFalgTxt.text02");
            _taskFalgTxt.setFrame(1);
            _isCompleteImg.visible = false;
            _hitTxtSprite = new Sprite();
            setTxtHitArea();
            addChild(_hitTxtSprite);
            _hitTxtSprite.addEventListener("click",__hitTxtSpriteHandler);
         }
         else
         {
            _taskFalgTxt.text = "";
            _isCompleteImg.visible = false;
            if(_hitTxtSprite)
            {
               _hitTxtSprite.removeEventListener("click",__hitTxtSpriteHandler);
               if(getChildIndex(_hitTxtSprite) >= 0)
               {
                  removeChild(_hitTxtSprite);
                  _hitTxtSprite.graphics.clear();
                  _hitTxtSprite = null;
               }
            }
         }
         buttonMode = true;
      }
      
      private function setTxtHitArea() : void
      {
         _hitTxtSprite.graphics.clear();
         _hitTxtSprite.graphics.beginFill(0,0);
         _hitTxtSprite.graphics.drawRect(0,0,_taskFalgTxt.width,_taskFalgTxt.height);
         _hitTxtSprite.x = _taskFalgTxt.x;
         _hitTxtSprite.y = _taskFalgTxt.y;
      }
      
      private function setJoinHitArea() : void
      {
         _hitSprite.graphics.clear();
         _hitSprite.graphics.beginFill(0,0);
         _hitSprite.graphics.drawRect(0,0,_itemBack.width,_itemBack.height);
         _hitSprite.x = _itemBack.x;
         _hitSprite.y = _itemBack.y;
      }
      
      public function get selected() : Boolean
      {
         return _itemSelected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _itemSelected = param1;
         if(_itemBack)
         {
            if(_itemSelected && _data)
            {
               _itemBack.visible = true;
            }
            else
            {
               _itemBack.visible = false;
            }
         }
      }
      
      public function mouseClickHandler(param1:MouseEvent) : void
      {
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",mouseClickHandler);
         if(_hitTxtSprite)
         {
            _hitTxtSprite.removeEventListener("click",__hitTxtSpriteHandler);
         }
      }
      
      private function __hitTxtSpriteHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = FrameControllerManager.instance.guideTaskController.frame;
         if(_loc2_)
         {
            if(thaneInfo.grades < _info.IParam5 || _info.Type == GuideTaskType.HEARO_LEVEL)
            {
               _loc2_.changePage(2);
            }
            else
            {
               SwitchPageHelp.switchGuidePage(_info.Type);
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemBack);
         _itemBack = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_taskDescTxt);
         _taskDescTxt = null;
         ObjectUtils.disposeObject(_openLvTxt);
         _openLvTxt = null;
         ObjectUtils.disposeObject(_isCompleteImg);
         _isCompleteImg = null;
         ObjectUtils.disposeObject(_taskFalgTxt);
         _taskFalgTxt = null;
         _hitSprite.graphics.clear();
         if(_hitTxtSprite)
         {
            _hitTxtSprite.graphics.clear();
            ObjectUtils.disposeObject(_hitTxtSprite);
            _hitTxtSprite = null;
         }
         ObjectUtils.disposeObject(_hitSprite);
         _hitSprite = null;
      }
      
      private function get thaneInfo() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}

