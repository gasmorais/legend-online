package childarena
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.children.ChildArenaPlayerInfo;
   
   public class ChildArenaPlayerItem extends Component
   {
      
      private var back:ScaleFrameImage;
      
      private var nameText:FilterFrameText;
      
      private var _data:ChildArenaPlayerInfo;
      
      public function ChildArenaPlayerItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("ChildArenaPlayerItem.back");
         nameText = ComponentFactory.Instance.creatComponentByStylename("ChildArenaPlayerItem.nameText");
         addChild(back);
         addChild(nameText);
         back.setFrame(1);
      }
      
      public function get data() : ChildArenaPlayerInfo
      {
         return _data;
      }
      
      public function set data(param1:ChildArenaPlayerInfo) : void
      {
         _data = param1;
         if(_data)
         {
            nameText.text = _data.nickName;
            this.tipData = _data.serverName + "_" + _data.nickName + "\n" + LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.fightingTxt",_data.fightPower);
         }
         else
         {
            nameText.text = LanguageMgr.GetTranslation("ChildArenaPlayerItem.nameText.text");
            this.tipData = null;
            back.setFrame(1);
         }
      }
      
      public function setBack(param1:int) : void
      {
         back.setFrame(param1);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(nameText);
         nameText = null;
         super.dispose();
      }
   }
}

