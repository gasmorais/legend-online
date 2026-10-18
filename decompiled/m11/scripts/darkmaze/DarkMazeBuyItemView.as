package darkmaze
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DarkMazeManager;
   import mvc.module.darkmaze.DarkMazeModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.view.community.BaseItemView;
   
   public class DarkMazeBuyItemView extends Component
   {
      
      private var _bg:MutipleImage;
      
      private var _priceTxt:FilterFrameText;
      
      private var _discountTxt:FilterFrameText;
      
      private var _buyBtn:IconButton;
      
      private var _baseItemView:BaseItemView;
      
      private var _dataArr:Array;
      
      private var _index:int;
      
      private var price:int;
      
      private var _nodeId:int;
      
      private var _nodeType:int;
      
      public function DarkMazeBuyItemView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("darkMazeBuyItemView.bg");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("darkMazeBuyItemView.priceTxt");
         _discountTxt = ComponentFactory.Instance.creatComponentByStylename("darkMazeBuyItemView.discountTxt");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("darkMazeBuyItemView.buyBtn");
         _baseItemView = ComponentFactory.Instance.creatCustomObject("darkMazeBuyItemView.baseItemView");
         addChild(_bg);
         addChild(_priceTxt);
         addChild(_discountTxt);
         addChild(_buyBtn);
         addChild(_baseItemView);
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_priceTxt);
         _priceTxt = null;
         ObjectUtils.disposeObject(_discountTxt);
         _discountTxt = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_baseItemView);
         _baseItemView = null;
      }
      
      private function initEvent() : void
      {
         if(_buyBtn)
         {
            _buyBtn.addEventListener("click",__buyBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__buyBtnHandler);
         }
      }
      
      private function __buyBtnHandler(param1:MouseEvent) : void
      {
         if(PlayerManager.instance.currentPlayerModel.playerInfo.point < price)
         {
            RechargeAlertMannager.show();
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc3_:String = LanguageMgr.GetTranslation("dungeonexplore.view.DungeonExploreBlackFrame.buyTips",price);
         SharedManagerHelper.ins.needAlert("DarkMazeBuyItemView.buyGoods.alert",buyGoodsResuletHandler,_loc2_,_loc3_);
      }
      
      private function buyGoodsResuletHandler() : void
      {
         model.selctedBuyIndex = _index;
         DarkMazeManager.instance.darkMazeOperation(6,_nodeId,_index);
      }
      
      public function set dataArr(param1:Array) : void
      {
         _dataArr = param1;
         if(!_dataArr || _dataArr.length <= 0)
         {
            return;
         }
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = _dataArr[0];
         _loc2_.count = _dataArr[1];
         _baseItemView.data = _loc2_;
         _priceTxt.text = _dataArr[2].toString();
         _discountTxt.text = _dataArr[3].toString() + "%";
         price = _dataArr[2];
      }
      
      public function set nodeId(param1:int) : void
      {
         _nodeId = param1;
      }
      
      public function set nodeType(param1:int) : void
      {
         _nodeType = param1;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
         if(model.buyInfoArr.length >= _index)
         {
            param1 = int(model.buyInfoArr[_index - 1]);
            _buyBtn.enable = param1 == 0;
         }
      }
      
      private function get model() : DarkMazeModel
      {
         return DarkMazeManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
   }
}

