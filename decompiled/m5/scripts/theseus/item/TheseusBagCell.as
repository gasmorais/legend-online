package theseus.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.theseus.WarFrameItemInfo;
   import theseus.mediator.TheseusBagCellClickMediator;
   import theseus.mediator.TheseusBagCellDropMediator;
   import yishi.manager.MediatorMananger;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseWarCell;
   
   public class TheseusBagCell extends BaseWarCell
   {
      
      public static const NAME:String = "theseus.item.TheseusBagCell";
      
      public static const P_NLVStyle:String = "lvStyle";
      
      public static const P_FullStyle:String = "fullStyle";
      
      public static const P_FullStyleY:String = "fullStyleY";
      
      public static const P_FullStyleX:String = "fullStyleX";
      
      protected var _mediatorKey:String;
      
      protected var _registed:Boolean;
      
      private var _strengNumSprite:Sprite;
      
      private var _strengImg:BitmapData;
      
      private var _lvStyle:String;
      
      private var _lvTxt:FilterFrameText;
      
      public const P_equipStyle:String = "equipStyle";
      
      private var _equipStyle:String;
      
      private var _equipFlg:Bitmap;
      
      private var _fullStyleY:int;
      
      private var _fullStyleX:int;
      
      private var _fullStyle:String;
      
      private var _fullBit:Bitmap;
      
      public function TheseusBagCell()
      {
         super();
      }
      
      public function set lvStyle(param1:String) : void
      {
         _lvStyle = param1;
         onPropertiesChanged("lvStyle");
      }
      
      public function set equipStyle(param1:String) : void
      {
         _equipStyle = param1;
         onPropertiesChanged("equipStyle");
      }
      
      public function set fullStyle(param1:String) : void
      {
         _fullStyle = param1;
         onPropertiesChanged("fullStyle");
      }
      
      public function set fullStyleY(param1:int) : void
      {
         _fullStyleY = param1;
         onPropertiesChanged("fullStyleY");
      }
      
      public function set fullStyleX(param1:int) : void
      {
         _fullStyleX = param1;
         onPropertiesChanged("fullStyleX");
      }
      
      protected function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [TheseusBagCellClickMediator,TheseusBagCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"theseus.item.TheseusBagCell");
      }
      
      protected function unregisterMediator() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["lvStyle"])
         {
            _lvTxt = ComponentFactory.Instance.creatComponentByStylename(_lvStyle);
         }
         if(_changedPropeties["fullStyle"])
         {
            _fullBit = ComponentFactory.Instance.creatBitmap(_fullStyle);
            _strengImg = ComponentFactory.Instance.creatBitmapData("asset.tips.numImg");
            if(_changedPropeties["fullStyleY"])
            {
               _fullBit.y = _fullStyleY;
            }
            if(_changedPropeties["fullStyleX"])
            {
               _fullBit.x = _fullStyleX;
            }
            _strengNumSprite = new Sprite();
            _fullBit.scaleX = _fullBit.scaleY = 0.9;
            _fullBit.x = 2;
            _fullBit.y = 1;
            _strengNumSprite.y = 5;
            _strengNumSprite.x = 12;
            _strengNumSprite.scaleX = _strengNumSprite.scaleY = 0.7;
            _strengNumSprite.mouseChildren = _strengNumSprite.mouseEnabled = false;
         }
         if(_changedPropeties["equipStyle"])
         {
            _equipFlg = ComponentFactory.Instance.creatBitmap(_equipStyle);
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_fullBit)
         {
            addChild(_fullBit);
            addChild(_strengNumSprite);
         }
         if(_equipFlg)
         {
            addChild(_equipFlg);
         }
         if(_lvTxt)
         {
            addChild(_lvTxt);
         }
      }
      
      private function setStrengNum(param1:int) : void
      {
         NumberViewUtils.refreshValue(param1,_strengNumSprite,_strengImg,19,22,10,19,"0123456789");
      }
      
      override public function set data(param1:WarFrameItemInfo) : void
      {
         if(data != param1)
         {
            setNormalFilter();
         }
         super.data = param1;
         mouseEnabled = true;
         mouseChildren = true;
         if(_lvTxt)
         {
            if(param1 && param1.warTempInfo.SonType == 720)
            {
               _lvTxt.text = LanguageMgr.GetTranslation("public.level2",param1.warTempInfo.Property4);
            }
            else
            {
               _lvTxt.text = "";
            }
         }
         if(_equipFlg)
         {
            if(param1)
            {
               _equipFlg.visible = param1.isEquip;
            }
            else
            {
               _equipFlg.visible = false;
            }
         }
         if(_fullBit)
         {
            if(param1)
            {
               _fullBit.visible = param1.strengthen > 0;
               _strengNumSprite.visible = param1.strengthen > 0;
               setStrengNum(param1.strengthen);
            }
            else
            {
               _fullBit.visible = false;
               _strengNumSprite.visible = false;
            }
         }
         if(!_registed)
         {
            registerMediator();
         }
      }
      
      override public function dispose() : void
      {
         unregisterMediator();
         ObjectUtils.disposeObject(_lvTxt);
         _lvTxt = null;
         ObjectUtils.disposeObject(_fullBit);
         _fullBit = null;
         ObjectUtils.disposeObject(_strengNumSprite);
         _strengNumSprite = null;
         ObjectUtils.disposeObject(_strengImg);
         _strengImg = null;
         ObjectUtils.disposeObject(_equipFlg);
         _equipFlg = null;
         super.dispose();
      }
   }
}

