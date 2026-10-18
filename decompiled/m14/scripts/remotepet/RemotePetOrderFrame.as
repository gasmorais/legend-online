package remotepet
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.RemotePetEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.RemotePetManager;
   import mvc.module.remotepet.RemotePetModel;
   import mvc.module.remotepet.RemotePetOrderInfo;
   import remotepet.views.RemotePetOrderItemView;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   
   public class RemotePetOrderFrame extends Frame implements IManualSize
   {
      
      public static var ONEPAGE:int = 10;
      
      private var _bg1:ScaleBitmapImage;
      
      private var _titleBg:MutipleImage;
      
      private var _orderTitle:FilterFrameText;
      
      private var _nameTitle:FilterFrameText;
      
      private var _indexTitle:FilterFrameText;
      
      private var _fightTitle:FilterFrameText;
      
      private var _vBox:VBox;
      
      private var _itemList:Vector.<RemotePetOrderItemView>;
      
      private var _selfValue:RemotePetOrderItemView;
      
      private var _type:int;
      
      public function RemotePetOrderFrame()
      {
         FrameControllerManager.instance.remotePetController.loadRemotePetOrderData();
         super();
         initView();
         initItem();
         addEvent();
         refresh();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,265,480);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("remotepet.RemotePetOrderFrame.defTitle");
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetOrderFrame.bg1");
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetOrderFrame.titleBg");
         _orderTitle = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetOrderFrame.orderTitle");
         _nameTitle = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetOrderFrame.nameTitle");
         _indexTitle = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetOrderFrame.indexTitle");
         _fightTitle = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetOrderFrame.fightTitle");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetOrderFrame.vBox");
         addToContent(_bg1);
         addToContent(_titleBg);
         addToContent(_orderTitle);
         addToContent(_nameTitle);
         addToContent(_indexTitle);
         addToContent(_fightTitle);
         addToContent(_vBox);
         _orderTitle.text = LanguageMgr.GetTranslation("remotepet.RemotePetOrderFrame.orderTitle");
         _nameTitle.text = LanguageMgr.GetTranslation("remotepet.RemotePetOrderFrame.nameTitle");
         _indexTitle.text = LanguageMgr.GetTranslation("remotepet.RemotePetOrderFrame.indexTitle");
         _fightTitle.text = LanguageMgr.GetTranslation("remotepet.RemotePetOrderFrame.fightTitle");
         _selfValue = new RemotePetOrderItemView();
         _selfValue.y = 450;
         addToContent(_selfValue);
      }
      
      private function initItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RemotePetOrderItemView = null;
         _itemList = new Vector.<RemotePetOrderItemView>();
         _loc2_ = 0;
         while(_loc2_ < ONEPAGE)
         {
            _loc1_ = new RemotePetOrderItemView();
            _vBox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         model.addEventListener("ORDERDATA_LOAD_COMPLETE",__completeHandler);
         model.addEventListener("UPDATEORDER",__updateHandler);
      }
      
      private function __updateHandler(param1:RemotePetEvent) : void
      {
         FrameControllerManager.instance.remotePetController.loadRemotePetOrderData();
      }
      
      private function __completeHandler(param1:RemotePetEvent) : void
      {
         refresh();
      }
      
      private function refresh() : void
      {
         var _loc2_:int = 0;
         if(model.orderList.length > 0)
         {
            titleText = LanguageMgr.GetTranslation("remotepet.RemotePetOrderFrame.title",model.orderTime.hours);
            _loc2_ = 0;
            while(_loc2_ < model.orderList.length)
            {
               if(model.orderList[_loc2_])
               {
                  _itemList[_loc2_].data = model.orderList[_loc2_];
               }
               _loc2_++;
            }
         }
         var _loc1_:RemotePetOrderInfo = new RemotePetOrderInfo();
         _loc1_.userId = ArmyManager.instance.thane.userId;
         _loc1_.fight = model.petListInfo.fight;
         _loc1_.nickName = ArmyManager.instance.thane.nickName;
         _loc1_.consortiaName = ArmyManager.instance.thane.consortiaName;
         _loc1_.grades = ArmyManager.instance.thane.grades;
         _loc1_.order = model.rank;
         _loc1_.index = model.turnInfo.currTurn - 1;
         if(_loc1_.index < 0)
         {
            _loc1_.index = 0;
         }
         _loc1_.grades = ArmyManager.instance.thane.grades;
         _loc1_.isVip = ArmyManager.instance.thane.IsVipAndNoExpirt;
         _selfValue.data = _loc1_;
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               if(_type == 1)
               {
                  dispose();
                  break;
               }
               visible = false;
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         model.removeEventListener("ORDERDATA_LOAD_COMPLETE",__completeHandler);
         model.removeEventListener("UPDATEORDER",__updateHandler);
      }
      
      private function get model() : RemotePetModel
      {
         return RemotePetManager.instance.model;
      }
      
      public function show(param1:int = 0) : void
      {
         _type = param1;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

