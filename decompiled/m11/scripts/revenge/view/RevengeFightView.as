package revenge.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class RevengeFightView extends Sprite
   {
      
      public var _fightBack:MutipleImage;
      
      public var _ftBtn:BaseButton;
      
      public var _fbtnTxt:FilterFrameText;
      
      public var _fristBox:HBox;
      
      public var _maybeBox:HBox;
      
      public var _bossBuyBtn:BaseButton;
      
      public var _saodanBtn:IconButton;
      
      public var _bossNum:FilterFrameText;
      
      public var _fgetFlg:Image;
      
      public function RevengeFightView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _fightBack = ComponentFactory.Instance.creatComponentByStylename("ui.revengeroad.fightBack");
         _ftBtn = ComponentFactory.Instance.creatComponentByStylename("ui.revengeroad.ftBtn");
         _fbtnTxt = ComponentFactory.Instance.creatComponentByStylename("ui.revengeroad.fbtnTxt");
         _fristBox = ComponentFactory.Instance.creatCustomObject("ui.revengeroad.fristBox");
         _maybeBox = ComponentFactory.Instance.creatCustomObject("ui.revengeroad.maybeBox");
         _bossNum = ComponentFactory.Instance.creatComponentByStylename("ui.revengeroad.bossNum");
         _bossBuyBtn = ComponentFactory.Instance.creatComponentByStylename("ui.revengeroad.bossBuyBtn");
         _fgetFlg = ComponentFactory.Instance.creatComponentByStylename("ui.revengeroad.fgetFlg");
         _saodanBtn = ComponentFactory.Instance.creatComponentByStylename("ui.revengeroad.saodang");
         addChild(_fightBack);
         addChild(_fristBox);
         addChild(_maybeBox);
         addChild(_fgetFlg);
         addChild(_ftBtn);
         addChild(_bossNum);
         addChild(_bossBuyBtn);
         addChild(_saodanBtn);
         _ftBtn.addChild(_fbtnTxt);
         _fgetFlg.visible = false;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_fightBack);
         _fightBack = null;
         ObjectUtils.disposeObject(_ftBtn);
         _ftBtn = null;
         ObjectUtils.disposeObject(_fbtnTxt);
         _fbtnTxt = null;
         ObjectUtils.disposeObject(_fristBox);
         _fristBox = null;
         ObjectUtils.disposeObject(_maybeBox);
         _maybeBox = null;
         ObjectUtils.disposeObject(_bossNum);
         _bossNum = null;
         ObjectUtils.disposeObject(_bossBuyBtn);
         _bossBuyBtn = null;
         ObjectUtils.disposeObject(_fgetFlg);
         _fgetFlg = null;
         ObjectUtils.disposeObject(_saodanBtn);
         _saodanBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

