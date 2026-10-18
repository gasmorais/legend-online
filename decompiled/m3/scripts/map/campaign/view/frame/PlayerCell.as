package map.campaign.view.frame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseItemView;
   
   public class PlayerCell extends Sprite implements Disposeable
   {
      
      private var _icon:BaseItemView;
      
      private var _iconBg:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _data:ThaneInfo;
      
      public function PlayerCell()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _iconBg = ComponentFactory.Instance.creatBitmap("asset.core.army.SubHeroBack");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.room.PrepareBattlePlayerNameTxt");
         _nameTxt.text = LanguageMgr.GetTranslation("map.campaign.view.frame.PlayerCell.nameTxt.text");
         _icon = ComponentFactory.Instance.creatCustomObject("campaign.palyerCell.PrepareFrameItemView");
         _icon.x = _icon.y = 0;
         addChild(_icon);
         addChild(_nameTxt);
      }
      
      private function uninit() : void
      {
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
         }
         _icon = null;
         ObjectUtils.disposeAllChildren(this);
         _data = null;
      }
      
      public function get data() : ThaneInfo
      {
         return _data;
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         _data = param1;
         _nameTxt.text = _data.nickName;
         _icon.icon.icon = IconFactory.getPlayerIcon(param1.pics,"half");
      }
      
      public function dispose() : void
      {
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

