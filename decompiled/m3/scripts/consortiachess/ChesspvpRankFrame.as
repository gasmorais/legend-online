package consortiachess
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import consortiachess.view.ChesspvpRankView;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.ChessPvpManager;
   import mvc.module.chesspvp.ChessPvpOp;
   import yishi.datas.ComponentGroupType;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   
   public class ChesspvpRankFrame extends Frame
   {
      
      private var _leftbg:ScaleBitmapImage;
      
      private var _tabBox:VBox;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _zuanShiBtn:SelectedButton;
      
      private var _huanJinBtn:SelectedButton;
      
      private var _baiYinBtn:SelectedButton;
      
      private var _qinTongBtn:SelectedButton;
      
      private var _rightView:ChesspvpRankView;
      
      private var _rwbtn:IconButton;
      
      private var _dic:Dictionary;
      
      public function ChesspvpRankFrame()
      {
         super();
         initView();
         initEvent();
         ChessPvpManager.Instance.operFun(ChessPvpOp.OP_VIEW_RANK);
      }
      
      private function initView() : void
      {
         _leftbg = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rank.LeftViewBg");
         _zuanShiBtn = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rank.zuanShiBtn");
         _huanJinBtn = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rank.huanjinBtn");
         _baiYinBtn = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rank.baiYinBtn");
         _qinTongBtn = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rank.qiTongBtn");
         _tabBox = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.rank.tabBox");
         _rightView = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.rankView");
         _rwbtn = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rkRwBtn");
         addToContent(_leftbg);
         addToContent(_tabBox);
         addToContent(_rightView);
         addToContent(_rwbtn);
         _buttonGroup = new SelectedButtonGroup();
         _buttonGroup.addSelectItem(_zuanShiBtn);
         _buttonGroup.addSelectItem(_huanJinBtn);
         _buttonGroup.addSelectItem(_baiYinBtn);
         _buttonGroup.addSelectItem(_qinTongBtn);
         _tabBox.beginChanges();
         _tabBox.addChild(_zuanShiBtn);
         _tabBox.addChild(_huanJinBtn);
         _tabBox.addChild(_baiYinBtn);
         _tabBox.addChild(_qinTongBtn);
         _tabBox.commitChanges();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _buttonGroup.addEventListener("change",__onChangeHandler);
         _rwbtn.addEventListener("click",rwClickHandler);
         NotificationManager.instance.addEventListener(ChessPvpOp.EVENT_OP_FUN,updataHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _buttonGroup.removeEventListener("change",__onChangeHandler);
         _rwbtn.removeEventListener("click",rwClickHandler);
         NotificationManager.instance.removeEventListener(ChessPvpOp.EVENT_OP_FUN,updataHandler);
      }
      
      private function updataHandler(param1:NotificationEvent) : void
      {
         var _loc2_:Array = param1.data as Array;
         if(_loc2_ && _loc2_[0] == ChessPvpOp.OP_VIEW_RANK)
         {
            _dic = _loc2_[1];
            _buttonGroup.selectIndex = 0;
         }
      }
      
      private function rwClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("chesspvp",6);
      }
      
      private function __onChangeHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(_dic == null)
         {
            return;
         }
         SoundManager.instance.play("022");
         var _loc4_:ISelectable;
         switch(_loc4_ = _buttonGroup.getSelectedItem())
         {
            case _zuanShiBtn:
               _loc2_ = 3;
               break;
            case _huanJinBtn:
               _loc2_ = 2;
               break;
            case _baiYinBtn:
               _loc2_ = 1;
               break;
            case _qinTongBtn:
               _loc2_ = 0;
         }
         var _loc3_:Array = _dic[_loc2_];
         _rightView.refreshData(_loc3_,_loc2_);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_zuanShiBtn);
         _zuanShiBtn = null;
         ObjectUtils.disposeObject(_huanJinBtn);
         _huanJinBtn = null;
         ObjectUtils.disposeObject(_baiYinBtn);
         _baiYinBtn = null;
         ObjectUtils.disposeObject(_qinTongBtn);
         _qinTongBtn = null;
         ObjectUtils.disposeObject(_tabBox);
         _tabBox = null;
         ObjectUtils.disposeObject(_buttonGroup);
         _buttonGroup = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         ObjectUtils.disposeObject(_leftbg);
         _leftbg = null;
         ObjectUtils.disposeObject(_rwbtn);
         _rwbtn = null;
         super.dispose();
         _dic = null;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("chesspvp.rank.title");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

