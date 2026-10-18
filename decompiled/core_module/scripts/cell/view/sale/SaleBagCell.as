package cell.view.sale
{
   import cell.mediator.sale.SaleBagCellClickMediator;
   import cell.view.bag.BaseBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import manager.LanguageMgr;
   import managers.SaleManager;
   import mvc.module.sale.SaleData;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.MediatorMananger;
   
   public class SaleBagCell extends BaseBagCell
   {
      
      public static const NAME:String = "cell.view.sale.SaleBagCell";
      
      protected var _mediatorKey:String;
      
      protected var _registed:Boolean;
      
      private var _state:FilterFrameText;
      
      public function SaleBagCell()
      {
         super();
         _state = ComponentFactory.Instance.creatComponentByStylename("SaleBagCell.state");
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         var _loc2_:SaleData = null;
         if(_loc2_ != param1)
         {
            setNormalFilter();
         }
         super.data = param1;
         mouseEnabled = true;
         mouseChildren = true;
         if(!_registed)
         {
            registerMediator();
         }
         if(_state && param1)
         {
            _loc2_ = SaleManager.instance.model.getItemByAuctionId(param1.id);
            if(_loc2_.states == 1)
            {
               _state.text = LanguageMgr.GetTranslation("SaleBagCell.state1");
               _state.setFrame(1);
            }
            else if(_loc2_.states == 3)
            {
               _state.text = LanguageMgr.GetTranslation("SaleBagCell.state2");
               _state.setFrame(2);
            }
            else
            {
               _state.text = "";
            }
         }
         else if(_state)
         {
            _state.text = "";
         }
      }
      
      override protected function addChildren() : void
      {
         if(_back)
         {
            addChild(_back);
         }
         if(_lockImg)
         {
            addChild(_lockImg);
         }
         if(_icon)
         {
            addChild(_icon);
         }
         if(_shape)
         {
            addChild(_shape);
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
         if(_fashionImage)
         {
            addChild(_fashionImage);
         }
         if(_fashionText)
         {
            addChild(_fashionText);
         }
         if(_state)
         {
            addChild(_state);
         }
      }
      
      protected function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [SaleBagCellClickMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"cell.view.sale.SaleBagCell");
      }
      
      protected function unregisterMediator() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
      }
      
      override public function dispose() : void
      {
         unregisterMediator();
         super.dispose();
      }
   }
}

