package guidetask
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.guidetask.GuideTaskUpgradeInfo;
   import yishi.SwitchPageHelp;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class GuideLevelItem extends Sprite implements Disposeable, ISelectable
   {
      
      private var _back:Scale9CornerImage;
      
      private var _line:MutipleImage;
      
      private var _descText:FilterFrameText;
      
      private var _recommendTxt:GradientText;
      
      private var _gotoBtn:BaseButton;
      
      private var _data:GuideTaskUpgradeInfo;
      
      private var _itemSelected:Boolean;
      
      private var _hitSprite:Sprite;
      
      public function GuideLevelItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("guidetask.selectedHightline.image");
         _line = ComponentFactory.Instance.creatComponentByStylename("guidetask.itemline");
         _descText = ComponentFactory.Instance.creatComponentByStylename("guidetask.levelDescTxt");
         _recommendTxt = ComponentFactory.Instance.creatComponentByStylename("guidetask.recommendTxt_2");
         _gotoBtn = ComponentFactory.Instance.creatComponentByStylename("guidetask.gotoBtn");
         addChild(_back);
         _back.visible = false;
         addChild(_line);
         _hitSprite = new Sprite();
         setJoinHitArea();
         addChild(_hitSprite);
      }
      
      private function initEvent() : void
      {
         _gotoBtn.addEventListener("click",__gotoBtnHandler);
      }
      
      private function setJoinHitArea() : void
      {
         _hitSprite.graphics.clear();
         _hitSprite.graphics.beginFill(0,0);
         _hitSprite.graphics.drawRect(0,0,_back.width,_back.height);
         _hitSprite.x = _back.x;
         _hitSprite.y = _back.y;
      }
      
      private function removeEvent() : void
      {
         _gotoBtn.removeEventListener("click",__gotoBtnHandler);
      }
      
      private function __gotoBtnHandler(param1:MouseEvent) : void
      {
         switch(int(_data.type) - 1)
         {
            case 0:
               SwitchPageHelp.gotoCampaignById(9004);
               break;
            case 1:
               SwitchPageHelp.gotoCampaignById(9004);
               break;
            case 2:
               SwitchPageHelp.gotoMazeFrame();
               break;
            case 3:
               SwitchPageHelp.gotoOfferRewardFrame();
               break;
            case 4:
               NotificationManager.instance.dispatchEvent(new NotificationEvent("SHOWCAMPAIGN"));
         }
      }
      
      public function get selected() : Boolean
      {
         return _itemSelected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _itemSelected = param1;
         if(_itemSelected && _data)
         {
            if(_back)
            {
               _back.visible = true;
            }
         }
         else if(_back)
         {
            _back.visible = false;
         }
      }
      
      public function set data(param1:GuideTaskUpgradeInfo) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         if(_data.param1 > 0)
         {
            addChild(_descText);
            _descText.text = param1.desc;
            if(param1.expSort == 1)
            {
               addChild(_recommendTxt);
               _recommendTxt.text = LanguageMgr.GetTranslation("guidetask.GuideLevelItem.recommendTxt.text");
            }
            else if(param1.expSort == 0)
            {
               _recommendTxt.text = "";
            }
            addChild(_gotoBtn);
         }
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_descText);
         _descText = null;
         ObjectUtils.disposeObject(_recommendTxt);
         _recommendTxt = null;
         ObjectUtils.disposeObject(_gotoBtn);
         _gotoBtn = null;
         _hitSprite.graphics.clear();
         _hitSprite = null;
      }
   }
}

