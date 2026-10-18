package consortiachess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.ChessPvpManager;
   import mvc.module.chesspvp.ChesspvpRoleInfo;
   import yishi.utils.DateFormatter;
   
   public class ChesspvpRiverCdItem extends Sprite
   {
      
      private var _tipTxt:FilterFrameText;
      
      private var _tip2Txt:FilterFrameText;
      
      private var _cdTxt:FilterFrameText;
      
      private var _info:ChesspvpRoleInfo;
      
      public function ChesspvpRiverCdItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _info = ChessPvpManager.Instance.model.selfInfo;
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.briverCdTitleTxt");
         _cdTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.briverCdTxt");
         _tip2Txt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.riverCdTipTxt");
         addChild(_tip2Txt);
         addChild(_tipTxt);
         addChild(_cdTxt);
         _tipTxt.text = LanguageMgr.GetTranslation("chesspvp.battle.waitRiverTitle");
      }
      
      public function updateView() : void
      {
         if(_info)
         {
            switch(int(_info.state) - 3)
            {
               case 0:
                  this.visible = true;
                  if(_info.reiverTime == 3)
                  {
                     _tip2Txt.text = LanguageMgr.GetTranslation("chesspvp.battle.Noriver");
                     _tipTxt.visible = false;
                     _cdTxt.visible = false;
                  }
                  else
                  {
                     _cdTxt.visible = true;
                     _cdTxt.text = DateFormatter.getCountDate(_info.reiverCd,2,2);
                  }
                  break;
               default:
                  this.visible = false;
            }
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_cdTxt);
         _cdTxt = null;
         ObjectUtils.disposeObject(_tipTxt);
         _tipTxt = null;
         ObjectUtils.disposeObject(_tip2Txt);
         _tip2Txt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _info = null;
      }
   }
}

