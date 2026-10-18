package funny.groupbuy
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import manager.LanguageMgr;
   import managers.ShopManager;
   import mvc.module.shop.MainShopInfo;
   
   public class GroupBuyProgressBar extends Component
   {
      
      private var _mc:MovieClip;
      
      private var _numArr:Array;
      
      private var _buyNumTxt1:GradientText;
      
      private var _buyNumTxt2:GradientText;
      
      private var _buyNumTxt3:GradientText;
      
      private var _buyNumTxt4:GradientText;
      
      private var _jianzuan1:JianzuanItem;
      
      private var _jianzuan2:JianzuanItem;
      
      private var _jianzuan3:JianzuanItem;
      
      private var _jianzuan4:JianzuanItem;
      
      public function GroupBuyProgressBar()
      {
         super();
         initUI();
      }
      
      private function initUI() : void
      {
         _mc = ComponentFactory.Instance.creatCustomObject("groupbuy.progressbar");
         this.addChild(_mc);
         _mc.slidermask.x = -384;
         _buyNumTxt1 = ComponentFactory.Instance.creatComponentByStylename("groupbuy.buyNumTxt1");
         this.addChild(_buyNumTxt1);
         _buyNumTxt2 = ComponentFactory.Instance.creatComponentByStylename("groupbuy.buyNumTxt2");
         this.addChild(_buyNumTxt2);
         _buyNumTxt3 = ComponentFactory.Instance.creatComponentByStylename("groupbuy.buyNumTxt3");
         this.addChild(_buyNumTxt3);
         _buyNumTxt4 = ComponentFactory.Instance.creatComponentByStylename("groupbuy.buyNumTxt4");
         this.addChild(_buyNumTxt4);
         _jianzuan1 = new JianzuanItem();
         this.addChild(_jianzuan1);
         _jianzuan2 = new JianzuanItem();
         this.addChild(_jianzuan2);
         _jianzuan3 = new JianzuanItem();
         this.addChild(_jianzuan3);
         _jianzuan4 = new JianzuanItem();
         this.addChild(_jianzuan4);
         _jianzuan1.y = 40;
         _jianzuan2.y = 40;
         _jianzuan3.y = 40;
         _jianzuan4.y = 40;
      }
      
      public function initData(param1:int) : void
      {
         var _loc2_:MainShopInfo = ShopManager.Instance.getMainShopInfoById(param1);
         _numArr = [];
         _numArr.push([_loc2_.level1,_loc2_.price - _loc2_.price1]);
         _numArr.push([_loc2_.level2,_loc2_.price - _loc2_.price2 - (_loc2_.price - _loc2_.price1)]);
         _numArr.push([_loc2_.level3,_loc2_.price - _loc2_.price3 - (_loc2_.price - _loc2_.price2)]);
         _buyNumTxt1.text = LanguageMgr.GetTranslation("funny.groupbuy.rengou1",0);
         _buyNumTxt2.text = LanguageMgr.GetTranslation("funny.groupbuy.rengou2",_numArr[0][0]);
         _buyNumTxt3.text = LanguageMgr.GetTranslation("funny.groupbuy.rengou2",_numArr[1][0]);
         _buyNumTxt4.text = LanguageMgr.GetTranslation("funny.groupbuy.rengou2",_numArr[2][0]);
         _jianzuan1.updateNum(0);
         _jianzuan2.updateNum(_numArr[0][1]);
         _jianzuan3.updateNum(_numArr[1][1]);
         _jianzuan4.updateNum(_numArr[2][1]);
         _jianzuan1.x = 18 - _jianzuan1.w * 0.5;
         _jianzuan2.x = 154 - _jianzuan2.w * 0.5;
         _jianzuan3.x = 290 - _jianzuan3.w * 0.5;
         _jianzuan4.x = 427 - _jianzuan4.w * 0.5;
      }
      
      public function updateNum(param1:int) : void
      {
         if(param1 <= _numArr[0][0])
         {
            _mc.slidermask.x = -404 + 136 * (param1 / _numArr[0][0]) + 20;
         }
         else if(param1 > _numArr[0][0] && param1 <= _numArr[1][0])
         {
            _mc.slidermask.x = -268 + 136 * ((param1 - _numArr[0][0]) / (_numArr[1][0] - _numArr[0][0])) + 20;
         }
         else if(param1 > _numArr[1][0] && param1 <= _numArr[2][0])
         {
            _mc.slidermask.x = -132 + 132 * ((param1 - _numArr[1][0]) / (_numArr[2][0] - _numArr[1][0])) + 20;
         }
         else
         {
            _mc.slidermask.x = 20;
         }
         _mc.guangdian.x = _mc.slidermask.x + 404;
      }
      
      override public function dispose() : void
      {
         _numArr = null;
         ObjectUtils.disposeObject(_mc);
         _mc = null;
         ObjectUtils.disposeObject(_buyNumTxt1);
         _buyNumTxt1 = null;
         ObjectUtils.disposeObject(_buyNumTxt2);
         _buyNumTxt2 = null;
         ObjectUtils.disposeObject(_buyNumTxt3);
         _buyNumTxt3 = null;
         ObjectUtils.disposeObject(_buyNumTxt4);
         _buyNumTxt4 = null;
         ObjectUtils.disposeObject(_jianzuan1);
         _jianzuan1 = null;
         ObjectUtils.disposeObject(_jianzuan2);
         _jianzuan2 = null;
         ObjectUtils.disposeObject(_jianzuan3);
         _jianzuan3 = null;
         ObjectUtils.disposeObject(_jianzuan4);
         _jianzuan4 = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

