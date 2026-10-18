package armyII.viewII.stone.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.view.base.PageBar;
   
   public class StoneBagOpUI extends Sprite
   {
      
      protected var _bbigg:Image;
      
      protected var _bsbbg:Image;
      
      protected var _bagsjicon:Image;
      
      protected var _bfjbtn2:IconButton;
      
      protected var _fjbtn1:IconButton;
      
      protected var _openLockBtn:BaseButton;
      
      protected var _bnum:FilterFrameText;
      
      protected var _opBtn0:SelectedButton;
      
      protected var _opBtn1:SelectedButton;
      
      protected var _opBtn2:SelectedButton;
      
      protected var _opBtn3:SelectedButton;
      
      protected var _opBtn4:SelectedButton;
      
      protected var _opBtn5:SelectedButton;
      
      protected var _bagbbox:HBox;
      
      protected var _bagkd:ScaleBitmapImage;
      
      protected var _bagspnumtxt:FilterFrameText;
      
      protected var _addboxBtn:BaseButton;
      
      protected var _combox:ComboBox;
      
      protected var _pagbar:PageBar;
      
      public function StoneBagOpUI()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bbigg = ComponentFactory.Instance.creatComponentByStylename("ui.army.bbigg");
         _bsbbg = ComponentFactory.Instance.creatComponentByStylename("ui.army.bsbbg");
         _bagsjicon = ComponentFactory.Instance.creatComponentByStylename("ui.army.bagsjicon");
         _bfjbtn2 = ComponentFactory.Instance.creatComponentByStylename("ui.army.bfjbtn2");
         _fjbtn1 = ComponentFactory.Instance.creatComponentByStylename("ui.army.fjbtn1");
         _openLockBtn = ComponentFactory.Instance.creatComponentByStylename("ui.army.openLockBtn");
         _bnum = ComponentFactory.Instance.creatComponentByStylename("ui.army.bnum");
         _opBtn0 = ComponentFactory.Instance.creatComponentByStylename("ui.army.opBtn0");
         _opBtn1 = ComponentFactory.Instance.creatComponentByStylename("ui.army.opBtn1");
         _opBtn2 = ComponentFactory.Instance.creatComponentByStylename("ui.army.opBtn2");
         _opBtn3 = ComponentFactory.Instance.creatComponentByStylename("ui.army.opBtn3");
         _opBtn4 = ComponentFactory.Instance.creatComponentByStylename("ui.army.opBtn4");
         _opBtn5 = ComponentFactory.Instance.creatComponentByStylename("ui.army.opBtn5");
         _bagbbox = ComponentFactory.Instance.creatCustomObject("ui.army.bagbbox");
         _bagkd = ComponentFactory.Instance.creatComponentByStylename("ui.army.bagkd");
         _bagspnumtxt = ComponentFactory.Instance.creatComponentByStylename("army.stone.bagspnumtxt");
         _combox = ComponentFactory.Instance.creatComponentByStylename("army.stone.QuickSellComBox");
         _addboxBtn = ComponentFactory.Instance.creatComponentByStylename("ui.army.addboxBtn");
         _pagbar = ComponentFactory.Instance.creatComponentByStylename("ui.army.runeStone.PageBar");
         addChild(_bbigg);
         addChild(_bsbbg);
         addChild(_bagsjicon);
         addChild(_bfjbtn2);
         addChild(_fjbtn1);
         addChild(_openLockBtn);
         addChild(_bnum);
         addChild(_bagbbox);
         addChild(_bagkd);
         addChild(_bagspnumtxt);
         addChild(_addboxBtn);
         addChild(_combox);
         addChild(_pagbar);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bbigg);
         _bbigg = null;
         ObjectUtils.disposeObject(_bsbbg);
         _bsbbg = null;
         ObjectUtils.disposeObject(_bagsjicon);
         _bagsjicon = null;
         ObjectUtils.disposeObject(_bfjbtn2);
         _bfjbtn2 = null;
         ObjectUtils.disposeObject(_fjbtn1);
         _fjbtn1 = null;
         ObjectUtils.disposeObject(_openLockBtn);
         _openLockBtn = null;
         ObjectUtils.disposeObject(_bnum);
         _bnum = null;
         ObjectUtils.disposeObject(_opBtn0);
         _opBtn0 = null;
         ObjectUtils.disposeObject(_opBtn1);
         _opBtn1 = null;
         ObjectUtils.disposeObject(_opBtn2);
         _opBtn2 = null;
         ObjectUtils.disposeObject(_opBtn3);
         _opBtn3 = null;
         ObjectUtils.disposeObject(_opBtn4);
         _opBtn4 = null;
         ObjectUtils.disposeObject(_opBtn5);
         _opBtn5 = null;
         ObjectUtils.disposeObject(_bagbbox);
         _bagbbox = null;
         ObjectUtils.disposeObject(_bagkd);
         _bagkd = null;
         ObjectUtils.disposeObject(_bagspnumtxt);
         _bagspnumtxt = null;
         ObjectUtils.disposeObject(_combox);
         _combox = null;
         ObjectUtils.disposeObject(_addboxBtn);
         _addboxBtn = null;
         ObjectUtils.disposeObject(_pagbar);
         _pagbar = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

