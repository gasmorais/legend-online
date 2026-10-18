package consortiachess.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChessPvpManager;
   import mvc.module.chesspvp.ChessPvpGroupInfo;
   import mvc.module.chesspvp.ChessPvpOp;
   
   public class ChesspvpInLeftGroupUI extends Sprite
   {
      
      protected var _bg2:Bitmap;
      
      protected var _groupTitle:GradientText;
      
      protected var _inLeftTitle:Image;
      
      protected var _inBattleBtn:IconButton;
      
      protected var _inTitle:FilterFrameText;
      
      protected var _inTimeTxt:FilterFrameText;
      
      protected var _inOtherTxt:FilterFrameText;
      
      protected var _inOtherScoreTxt:FilterFrameText;
      
      protected var _inScoreTxt:FilterFrameText;
      
      private var _desTxt:FilterFrameText;
      
      public function ChesspvpInLeftGroupUI()
      {
         super();
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _bg2 = ComponentFactory.Instance.creatBitmap("asset.chesspvp.in.bg2");
         _groupTitle = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inGrouptitle");
         _inLeftTitle = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inLeftTitle");
         _inBattleBtn = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inBattleBtn");
         _inTitle = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inTitle");
         _inTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inTimeTxt");
         _inOtherTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inOtherTxt");
         _inOtherScoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inOtherScoreTxt");
         _inScoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inScoreTxt");
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inTitleDes");
         addChild(_bg2);
         addChild(_groupTitle);
         addChild(_inLeftTitle);
         addChild(_inBattleBtn);
         addChild(_inTitle);
         addChild(_inTimeTxt);
         addChild(_inOtherTxt);
         addChild(_inOtherScoreTxt);
         addChild(_inScoreTxt);
         addChild(_desTxt);
         _desTxt.text = LanguageMgr.GetTranslation("chesspvp.in.jiondes");
         _inTitle.text = LanguageMgr.GetTranslation("chesspvp.in.nextTitle");
         _inTimeTxt.text = LanguageMgr.GetTranslation("chesspvp.in.time","--");
         _inOtherTxt.text = LanguageMgr.GetTranslation("chesspvp.in.battleVs","--","");
         _inOtherScoreTxt.text = LanguageMgr.GetTranslation("chesspvp.in.vsScore","--");
      }
      
      public function updateView(param1:ChessPvpGroupInfo) : void
      {
         var _loc2_:String = null;
         _groupTitle.text = LanguageMgr.GetTranslation("chesspvp.in.groupName" + param1.group);
         _inScoreTxt.text = LanguageMgr.GetTranslation("chesspvp.in.selfScore",param1.score);
         _inTimeTxt.text = LanguageMgr.GetTranslation("chesspvp.in.time",param1.beginTime);
         switch(int(param1.state))
         {
            case 0:
               _loc2_ = LanguageMgr.GetTranslation("chesspvp.in.noMatch");
               _inOtherTxt.text = LanguageMgr.GetTranslation("chesspvp.in.battleVs",_loc2_,"");
               _inOtherScoreTxt.text = LanguageMgr.GetTranslation("chesspvp.in.vsScore","--");
               _inBattleBtn.enable = false;
               break;
            case 1:
               _inOtherTxt.text = LanguageMgr.GetTranslation("chesspvp.in.battleVs",param1.rivalServerName,param1.rivalName);
               _inOtherScoreTxt.text = LanguageMgr.GetTranslation("chesspvp.in.vsScore",param1.rivalScore);
               _inBattleBtn.enable = true;
               break;
            case 2:
               _loc2_ = LanguageMgr.GetTranslation("chesspvp.in.noVs");
               _inOtherTxt.text = LanguageMgr.GetTranslation("chesspvp.in.battleVs",_loc2_,"");
               _inOtherScoreTxt.text = LanguageMgr.GetTranslation("chesspvp.in.vsScore","--");
               _inBattleBtn.enable = false;
         }
      }
      
      private function initEvent() : void
      {
         _inBattleBtn.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         _inBattleBtn.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         ChessPvpManager.Instance.operFun(ChessPvpOp.OP_FIGHT);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg2);
         _bg2 = null;
         ObjectUtils.disposeObject(_groupTitle);
         _groupTitle = null;
         ObjectUtils.disposeObject(_inLeftTitle);
         _inLeftTitle = null;
         ObjectUtils.disposeObject(_inBattleBtn);
         _inBattleBtn = null;
         ObjectUtils.disposeObject(_inTitle);
         _inTitle = null;
         ObjectUtils.disposeObject(_inTimeTxt);
         _inTimeTxt = null;
         ObjectUtils.disposeObject(_inOtherTxt);
         _inOtherTxt = null;
         ObjectUtils.disposeObject(_inOtherScoreTxt);
         _inOtherScoreTxt = null;
         ObjectUtils.disposeObject(_inScoreTxt);
         _inScoreTxt = null;
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

