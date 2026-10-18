package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.pet.PetData;
   
   public class PetTip extends BaseTip
   {
      
      public static const NONE:int = 0;
      
      public static const EQUIPED:int = 1;
      
      public static const COMPOSE1:int = 2;
      
      public static const COMPOSE2:int = 3;
      
      private var _blackKingBg:Scale9CornerImage;
      
      private var _redBg:Scale9CornerImage;
      
      private var _yellowBg:Scale9CornerImage;
      
      private var _purpleBg:Scale9CornerImage;
      
      private var _blueBg:Scale9CornerImage;
      
      private var _greenBg:Scale9CornerImage;
      
      private var _whiteBg:Scale9CornerImage;
      
      private var equipedTxt:FilterFrameText;
      
      private var content:PetTipContent;
      
      private var _state:Boolean = false;
      
      private var _type:int;
      
      public function PetTip()
      {
         super();
      }
      
      public function set state(param1:Boolean) : void
      {
         _state = param1;
      }
      
      override protected function init() : void
      {
         super.init();
         _blackKingBg = ComponentFactory.Instance.creatComponentByStylename("core.blackItemTipsBg");
         _redBg = ComponentFactory.Instance.creatComponentByStylename("core.redItemTipsBg");
         _yellowBg = ComponentFactory.Instance.creatComponentByStylename("core.yellowItemTipsBg");
         _purpleBg = ComponentFactory.Instance.creatComponentByStylename("core.purpleItemTipsBg");
         _blueBg = ComponentFactory.Instance.creatComponentByStylename("core.blueItemTipsBg");
         _greenBg = ComponentFactory.Instance.creatComponentByStylename("core.greenItemTipsBg");
         _whiteBg = ComponentFactory.Instance.creatComponentByStylename("core.whiteItemTipsBg");
         addChild(_blackKingBg);
         addChild(_redBg);
         addChild(_yellowBg);
         addChild(_purpleBg);
         addChild(_blueBg);
         addChild(_greenBg);
         addChild(_whiteBg);
         equipedTxt = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsEquiped_2");
         equipedTxt.y = 23;
         equipedTxt.width = 170;
         equipedTxt.x = 74;
         equipedTxt.text = LanguageMgr.GetTranslation("PetTip.currentPet");
         content = new PetTipContent();
         _bg.width = 287;
         _bg.height = 310;
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:int = 0;
         if(type == 1)
         {
            equipedTxt.text = LanguageMgr.GetTranslation("PetTip.currentPet");
            addChild(equipedTxt);
            _loc1_ += equipedTxt.textHeight + 13;
            content.y = equipedTxt.y + equipedTxt.textHeight - 17;
         }
         else if(type == 2)
         {
            equipedTxt.text = LanguageMgr.GetTranslation("PetTip.beforeCompose");
            addChild(equipedTxt);
            _loc1_ += equipedTxt.textHeight + 5;
            content.y = equipedTxt.y + equipedTxt.textHeight;
         }
         else if(type == 3)
         {
            equipedTxt.text = LanguageMgr.GetTranslation("PetTip.afterCompose");
            addChild(equipedTxt);
            _loc1_ += equipedTxt.textHeight + 5;
            content.y = equipedTxt.y + equipedTxt.textHeight;
         }
         else
         {
            if(this.contains(equipedTxt))
            {
               removeChild(equipedTxt);
            }
            if(_state)
            {
               equipedTxt.text = "";
               addChild(equipedTxt);
               _loc1_ += 27;
               content.y = equipedTxt.y + -3;
            }
            else
            {
               content.y = 0;
            }
         }
         addChild(content);
         if(tipData is PetData)
         {
            content.data = tipData as PetData;
         }
         _bg.height = _loc1_ + content.height + 17;
         _blackKingBg.width = _redBg.width = _yellowBg.width = _purpleBg.width = _blueBg.width = _greenBg.width = _whiteBg.width = _bg.width;
         _blackKingBg.height = _redBg.height = _yellowBg.height = _purpleBg.height = _blueBg.height = _greenBg.height = _whiteBg.height = _bg.height - 10;
         if(tipData)
         {
            showProfileBg((tipData as PetData).quality);
         }
      }
      
      private function showProfileBg(param1:int) : void
      {
         _blackKingBg.visible = _redBg.visible = _yellowBg.visible = _purpleBg.visible = _blueBg.visible = _greenBg.visible = _whiteBg.visible = _bg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               _whiteBg.visible = true;
               break;
            case 1:
               _greenBg.visible = true;
               break;
            case 2:
               _blueBg.visible = true;
               break;
            case 3:
               _purpleBg.visible = true;
               break;
            case 4:
               _yellowBg.visible = true;
               break;
            case 5:
               _redBg.visible = true;
               break;
            case 6:
               _blackKingBg.visible = true;
         }
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(equipedTxt);
         equipedTxt = null;
         ObjectUtils.disposeObject(content);
         content = null;
         ObjectUtils.disposeObject(_redBg);
         _redBg = null;
         ObjectUtils.disposeObject(_yellowBg);
         _yellowBg = null;
         ObjectUtils.disposeObject(_purpleBg);
         _purpleBg = null;
         ObjectUtils.disposeObject(_blueBg);
         _blueBg = null;
         ObjectUtils.disposeObject(_greenBg);
         _greenBg = null;
         ObjectUtils.disposeObject(_whiteBg);
         _whiteBg = null;
         ObjectUtils.disposeObject(_blackKingBg);
         _blackKingBg = null;
         super.dispose();
      }
   }
}

