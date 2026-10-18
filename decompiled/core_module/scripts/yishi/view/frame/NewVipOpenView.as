package yishi.view.frame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.TextEvent;
   import manager.LanguageMgr;
   import managers.VIPManager;
   import mvc.module.vip.VipInfo;
   import yishi.datas.templates.VipPrerogativeInfo;
   import yishi.manager.FrameControllerManager;
   
   public class NewVipOpenView extends Component implements Disposeable
   {
      
      public var _nickNameTxt:FilterFrameText;
      
      private var _vipType:int;
      
      private var _callback:Function;
      
      private var _reduce:int;
      
      public function NewVipOpenView(param1:int, param2:Function = null)
      {
         super();
         _vipType = param1;
         _callback = param2;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _nickNameTxt = ComponentFactory.Instance.creatComponentByStylename("vip.vipOpenViewTxt");
         addChild(_nickNameTxt);
      }
      
      private function addEvent() : void
      {
         _nickNameTxt.addEventListener("link",__onLinkHandler);
         VIPManager.Instance.model.addEventListener("upframeview_change",__vipChangeHandler);
         __vipChangeHandler(null);
      }
      
      private function removeEvent() : void
      {
         _nickNameTxt.removeEventListener("click",__onLinkHandler);
         VIPManager.Instance.model.removeEventListener("upframeview_change",__vipChangeHandler);
      }
      
      protected function __vipChangeHandler(param1:Event) : void
      {
         var _loc2_:int = -1;
         if(_vipType != -1)
         {
            _loc2_ = VIPManager.Instance.getMinVipPrerogativeGradeByType(_vipType);
         }
         if(vipInfo.IsVipAndNoExpirt && vipInfo.VipGrade >= _loc2_ && _loc2_ != 0)
         {
            _nickNameTxt.setFrame(2);
            _nickNameTxt.htmlText = getTipDataByTypeAndLevel(_vipType);
            _nickNameTxt.mouseEnabled = false;
         }
         else
         {
            _nickNameTxt.setFrame(1);
            _nickNameTxt.htmlText = "<a href =\'event: \'><u>" + getTipDataByType(_vipType) + "</u></a>";
            _nickNameTxt.mouseEnabled = true;
         }
         if(param1 && _callback is Function)
         {
            _callback();
            _callback = null;
         }
      }
      
      private function getTipDataByTypeAndLevel(param1:int) : String
      {
         var _loc2_:String = "";
         var _loc3_:VipPrerogativeInfo = VIPManager.Instance.getVipPrerogativeByTypeAndGrade(_vipType,vipInfo.VipGrade);
         _reduce = int(_loc3_.para1);
         switch(param1)
         {
            case 202:
               _loc2_ = LanguageMgr.GetTranslation("vip.newVipOpenView.tipsData1",_loc3_.grade,int(_loc3_.para1));
               break;
            case 15:
               break;
            case 203:
               _loc2_ = LanguageMgr.GetTranslation("vip.newVipOpenView.tipsData3",_loc3_.grade,int(_loc3_.para1) + 1);
               break;
            case 204:
               _loc2_ = LanguageMgr.GetTranslation("vip.newVipOpenView.tipsData4",_loc3_.grade,int(_loc3_.para1));
               break;
            case 23:
            case 205:
               _loc2_ = LanguageMgr.GetTranslation("vip.newVipOpenView.tipsData5",_loc3_.grade,int(_loc3_.para1));
               break;
            case 24:
               _loc2_ = LanguageMgr.GetTranslation("vip.newVipOpenView.tipsData7");
         }
         return _loc2_;
      }
      
      public function get reduce() : int
      {
         return _reduce;
      }
      
      private function getTipDataByType(param1:int) : String
      {
         var _loc3_:String = "";
         var _loc2_:int = VIPManager.Instance.getMinVipPrerogativeGradeByType(_vipType);
         switch(param1)
         {
            case 202:
               _loc3_ = LanguageMgr.GetTranslation("vip.newVipOpenView.tips1",_loc2_);
               break;
            case 15:
               break;
            case 203:
               _loc3_ = LanguageMgr.GetTranslation("vip.newVipOpenView.tips3",_loc2_);
               break;
            case 204:
               _loc3_ = LanguageMgr.GetTranslation("vip.newVipOpenView.tips4",_loc2_);
               break;
            case 205:
               _loc3_ = LanguageMgr.GetTranslation("vip.newVipOpenView.tips5",_loc2_);
               break;
            case 23:
               _loc3_ = LanguageMgr.GetTranslation("vip.newVipOpenView.tips6",_loc2_);
               break;
            case 24:
               _loc3_ = LanguageMgr.GetTranslation("vip.newVipOpenView.tips7",_loc2_);
         }
         return _loc3_;
      }
      
      public function setWordWrap() : void
      {
         _nickNameTxt.width = 165;
         _nickNameTxt.height = 44;
      }
      
      public function setWD(param1:int) : void
      {
         _nickNameTxt.width = param1;
      }
      
      protected function __onLinkHandler(param1:TextEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("vip");
      }
      
      private function get vipInfo() : VipInfo
      {
         return VIPManager.Instance.model.vipInfo;
      }
      
      public function get nickNameTxt() : FilterFrameText
      {
         return _nickNameTxt;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_nickNameTxt);
         _nickNameTxt = null;
         _callback = null;
         super.dispose();
      }
   }
}

