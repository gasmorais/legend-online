package cell.view.runebag
{
   import cell.mediator.runebag.RuneIntensifyBagCellClickMediator;
   import cell.mediator.runebag.RuneIntensifyBagCellDropMediator;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.StoreEvent;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.MediatorMananger;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseItemView;
   
   public class RuneIntensifyCell extends BaseItemView
   {
      
      public static const P_activeStyle:String = "activeStyle";
      
      public static const EQUIP:int = -1;
      
      public static const NAME:String = "cell.view.runebag.RuneIntensifyCell";
      
      private var _activeStyle:String;
      
      public var sonType:int;
      
      public var resetTip:String;
      
      private var _mediatorKey:String;
      
      private var _registed:Boolean;
      
      private var _activeBack:MovieImage;
      
      private var _countTxt:FilterFrameText;
      
      public function RuneIntensifyCell()
      {
         super();
         bagType = 0;
         pos = 0;
         setNormal();
         registerMediator();
         initView();
      }
      
      public function set activeStyle(param1:String) : void
      {
         _activeStyle = param1;
         onPropertiesChanged("activeStyle");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["activeStyle"])
         {
            _activeBack = ComponentFactory.Instance.creatComponentByStylename(_activeStyle);
            _activeBack.mouseChildren = false;
            _activeBack.mouseEnabled = false;
            _activeBack.movie.gotoAndStop(1);
            _activeBack.visible = false;
         }
      }
      
      override protected function addChildren() : void
      {
         if(_back)
         {
            addChild(_back);
         }
         if(_icon)
         {
            addChild(_icon);
         }
         if(_activeBack)
         {
            addChild(_activeBack);
         }
         if(_profile)
         {
            addChild(_profile);
         }
         if(_itemText)
         {
            addChild(_itemText);
         }
         if(_strengthenIcon)
         {
            addChild(_strengthenIcon);
         }
         if(_countTxt)
         {
            addChild(_countTxt);
         }
      }
      
      private function initView() : void
      {
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("army.rune.RuneIntensifyCellNumTxt");
      }
      
      protected function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [RuneIntensifyBagCellClickMediator,RuneIntensifyBagCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"cell.view.runebag.RuneIntensifyCell");
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         if(!_registed)
         {
            registerMediator();
         }
         SoundManager.instance.play("024",true);
         super.data = param1;
         if(param1)
         {
            _countTxt.text = param1.count + "";
         }
         else
         {
            _countTxt.text = "";
         }
         dispatchEvent(new StoreEvent("UPDATA_ITEM_DATA"));
      }
      
      override protected function setTipStyle(param1:GoodsTemplateInfo) : void
      {
         if(!StringHelper.isNullOrEmpty(resetTip))
         {
            icon.tipStyle = resetTip;
         }
         else
         {
            super.setTipStyle(param1);
         }
      }
      
      override public function dispose() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         ObjectUtils.disposeObject(_activeBack);
         _activeBack = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
      
      public function setNormal() : void
      {
         if(_activeBack)
         {
            _activeBack.visible = false;
            _activeBack.movie.gotoAndStop(1);
         }
      }
      
      public function setFocus() : void
      {
         if(_activeBack)
         {
            _activeBack.visible = true;
            _activeBack.movie.gotoAndPlay(1);
         }
      }
   }
}

