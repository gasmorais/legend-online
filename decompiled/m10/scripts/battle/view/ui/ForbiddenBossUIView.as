package battle.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.forbiddenboss.ForbiddenBossRankMsg;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.forbiddenboss.ForbiddenBossModel;
   import yishi.manager.ForbiddenBossManager;
   import yishi.utils.MsgMan;
   
   public class ForbiddenBossUIView extends Sprite implements Disposeable
   {
      
      private var _bg:MutipleImage;
      
      private var _nickNameTxt:FilterFrameText;
      
      private var _consortiaNameTxt:FilterFrameText;
      
      public function ForbiddenBossUIView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossUIView.bg");
         _nickNameTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossUIView.nickNameTxt");
         _consortiaNameTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossUIView.consortiaNameTxt");
         addChild(_bg);
         addChild(_nickNameTxt);
         addChild(_consortiaNameTxt);
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("FORBIDDEN_BOSS_RANK_UPDATE",this,__updateRankHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("FORBIDDEN_BOSS_RANK_UPDATE",this,__updateRankHandler);
      }
      
      private function __updateRankHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:ForbiddenBossRankMsg = null;
         var _loc2_:ForbiddenBossModel = ForbiddenBossManager.instance.model;
         if(_loc2_.rankList.length > 0)
         {
            _loc1_ = _loc2_.rankList[0];
            _nickNameTxt.text = _loc1_.nickName;
            if(_loc1_.consortiaName != "")
            {
               _consortiaNameTxt.text = LanguageMgr.GetTranslation("forbiddenBossRankItem.consortiaNameTxt.text",_loc1_.consortiaName);
            }
            else
            {
               _consortiaNameTxt.text = "";
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

