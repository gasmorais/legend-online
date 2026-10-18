package regress
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.CustomBitmap;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.regress.RegressRecordListMsg;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.templates.RegressTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.ArmyManager;
   import yishi.manager.RegressManager;
   import yishi.manager.TempleteManager;
   
   public class RegressItem extends Component
   {
      
      private var _sprite:Sprite;
      
      private var _titleTxt:FilterFrameText;
      
      private var _takedCountTxt:FilterFrameText;
      
      private var _receiveBtn1:IconButton;
      
      private var _line:DisplayObject;
      
      private var _receivedBmp:DisplayObject;
      
      private var _pointIcon4:CustomBitmap;
      
      private var _templateId:int;
      
      private var _filter:IFilterFormat;
      
      public function RegressItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _sprite = ComponentFactory.Instance.creatCustomObject("regress.RegressItem.Sprite");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("regress.regressItem.titleTxt");
         _takedCountTxt = ComponentFactory.Instance.creatComponentByStylename("regress.regressItem.takedCountTxt");
         _receiveBtn1 = ComponentFactory.Instance.creatComponentByStylename("regress.receiveBtn");
         _line = ComponentFactory.Instance.creatBitmap("asset.regress.regressLineBg");
         _receivedBmp = ComponentFactory.Instance.creatBitmap("asset.regress.receivedBmp");
         _pointIcon4 = ComponentFactory.Instance.creatCustomObject("regress.pointIcon4");
         addChild(_sprite);
         addChild(_line);
         addChild(_receivedBmp);
         addChild(_pointIcon4);
         _sprite.addChild(_titleTxt);
         _sprite.addChild(_takedCountTxt);
         _sprite.addChild(_receiveBtn1);
         _filter = new UIFilter();
      }
      
      public function setData(param1:int, param2:int = 0, param3:Boolean = false, param4:Boolean = true) : void
      {
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc5_:RegressTemplateInfo = TempleteManager.instance.regressTemplateCate.getTemplateByID(param1);
         _templateId = param1;
         switch(int(_loc5_.Types) - 1)
         {
            case 0:
               break;
            case 1:
               _loc10_ = int(ArmyManager.instance.thane.grades);
               _loc11_ = int(_loc5_.NeedGrades);
               _titleTxt.text = LanguageMgr.GetTranslation("regress.RegressItem.upgrades.txt",_loc11_,_loc10_,_loc11_);
               break;
            case 2:
               _loc10_ = param2;
               _loc11_ = int(_loc5_.LoginCount);
               _titleTxt.text = LanguageMgr.GetTranslation("regress.RegressItem.loginCount.txt",_loc11_,_loc10_,_loc11_);
         }
         var _loc6_:RegressRecordListMsg = RegressManager.instance.regressListMsg;
         var _loc9_:int = _loc5_.TakePercent * _loc6_.canTakeTotalCount / 100;
         var _loc7_:int = int(_loc5_.TakeData);
         var _loc8_:int = _loc9_ > 0 ? _loc9_ : _loc7_;
         _takedCountTxt.text = _loc8_.toString();
         _receiveBtn1.enable = true;
         _receiveBtn1.visible = true;
         _filter.setNormalFilter(_sprite);
         _receivedBmp.visible = false;
         if(param3)
         {
            if(param4)
            {
               _receiveBtn1.visible = false;
               _receivedBmp.visible = true;
               _filter.setGrayFilter(_sprite);
            }
         }
         else
         {
            _receiveBtn1.enable = false;
         }
      }
      
      private function addEvent() : void
      {
         _receiveBtn1.addEventListener("click",__receiveBtnHandler);
      }
      
      private function removeEvent() : void
      {
         _receiveBtn1.removeEventListener("click",__receiveBtnHandler);
      }
      
      private function __receiveBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         RegressManager.instance.OperatePoker(_templateId);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_takedCountTxt);
         _takedCountTxt = null;
         ObjectUtils.disposeObject(_receiveBtn1);
         _receiveBtn1 = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_receivedBmp);
         _receivedBmp = null;
         ObjectUtils.disposeObject(_pointIcon4);
         _pointIcon4 = null;
         ObjectUtils.disposeAllChildren(_sprite);
         ObjectUtils.disposeObject(_sprite);
         _sprite = null;
         _filter = null;
         super.dispose();
      }
   }
}

