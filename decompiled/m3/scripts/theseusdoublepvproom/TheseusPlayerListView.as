package theseusdoublepvproom
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseusPvpManager;
   import mvc.controler.TheseusRoomListControler;
   import mvc.module.pveroomlist.ThsesusRoomListModel;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpModel;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpUserInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.TheseusMultiPvpTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   
   public class TheseusPlayerListView extends Component
   {
      
      protected var _silkbannerBg:Bitmap;
      
      protected var _leftNametitleTxt:FilterFrameText;
      
      protected var _leftNameTxt:FilterFrameText;
      
      protected var _leftpointtitleTxt:FilterFrameText;
      
      protected var _leftpointTxt:FilterFrameText;
      
      protected var _leftrankTxt:FilterFrameText;
      
      protected var _leftranktitleTxt:FilterFrameText;
      
      protected var _leftzhanjiTxt:FilterFrameText;
      
      public var _redMatchIcon:ScaleFrameImage;
      
      private var _clickTime:int;
      
      public function TheseusPlayerListView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _silkbannerBg = ComponentFactory.Instance.creatBitmap("asset.theseuspve.double.silkbannerBg");
         _leftNametitleTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuepvp.leftNametitleTxt");
         _leftNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuepvp.leftNameTxt");
         _leftpointtitleTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuepvp.leftpointtitleTxt");
         _leftpointTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuepvp.leftpointTxt");
         _leftzhanjiTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuepvp.leftzhanjiTxt");
         _leftrankTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuepvp.leftrankTxt");
         _redMatchIcon = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.bottomIcon");
         _leftranktitleTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuepvp.leftranktitleTxt");
         _redMatchIcon.scaleX = _redMatchIcon.scaleY = 0.85;
         _redMatchIcon.x = 121;
         _redMatchIcon.y = 70;
         addChild(_silkbannerBg);
         addChild(_leftNametitleTxt);
         addChild(_leftNameTxt);
         addChild(_leftpointtitleTxt);
         addChild(_leftpointTxt);
         addChild(_leftrankTxt);
         addChild(_redMatchIcon);
         addChild(_leftranktitleTxt);
         _leftNametitleTxt.text = LanguageMgr.GetTranslation("theseusroomlist.RoomListFrame.desc5");
         _leftpointtitleTxt.text = LanguageMgr.GetTranslation("theseusroomlist.RoomListFrame.desc2");
         addChild(_leftzhanjiTxt);
         _leftranktitleTxt.htmlText = LanguageMgr.GetTranslation("theseusroomlist.RoomListFrame.desc9");
         _leftzhanjiTxt.htmlText = LanguageMgr.GetTranslation("theseusroomlist.RoomListFrame.desc1");
         refreshView();
      }
      
      private function initEvent() : void
      {
         _leftzhanjiTxt.addEventListener("click",__zhanjiHandler);
      }
      
      private function get model1() : TheseusDoublePvpModel
      {
         return TheseusPvpManager.Instance.model1;
      }
      
      private function refreshView() : void
      {
         var _loc2_:TheseusDoublePvpUserInfo = model1.selfUserInfo;
         _leftNameTxt.text = thane.nickName;
         _leftpointTxt.text = _loc2_.integral + "";
         var _loc1_:TheseusMultiPvpTempInfo = TempleteManager.instance.theseusMultiPvpTempCate.getTempById(_loc2_.pvpId);
         if(_loc1_)
         {
            _leftrankTxt.text = _loc1_.Name;
            _redMatchIcon.setFrame(_loc1_.MainType);
         }
      }
      
      private function removeEvent() : void
      {
         _leftzhanjiTxt.removeEventListener("click",__zhanjiHandler);
      }
      
      private function __zhanjiHandler(param1:MouseEvent) : void
      {
         TheseusPvpManager.Instance.doSomething1(5);
         FrameControllerManager.instance.openControllerByInfo("theseuspvp","REPORTDOUBLE");
      }
      
      private function __searchRoomHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         control.openSearchFrame();
      }
      
      private function get model() : ThsesusRoomListModel
      {
         return FrameControllerManager.instance.theseusRoomListControler.model;
      }
      
      private function get control() : TheseusRoomListControler
      {
         return FrameControllerManager.instance.theseusRoomListControler;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_silkbannerBg);
         _silkbannerBg = null;
         ObjectUtils.disposeObject(_leftNametitleTxt);
         _leftNametitleTxt = null;
         ObjectUtils.disposeObject(_leftNameTxt);
         _leftNameTxt = null;
         ObjectUtils.disposeObject(_leftpointtitleTxt);
         _leftpointtitleTxt = null;
         ObjectUtils.disposeObject(_leftpointTxt);
         _leftpointTxt = null;
         ObjectUtils.disposeObject(_leftzhanjiTxt);
         _leftzhanjiTxt = null;
         ObjectUtils.disposeObject(_leftrankTxt);
         _leftrankTxt = null;
         ObjectUtils.disposeObject(_redMatchIcon);
         _redMatchIcon = null;
         ObjectUtils.disposeObject(_leftranktitleTxt);
         _leftranktitleTxt = null;
         super.dispose();
      }
   }
}

