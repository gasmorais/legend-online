package consortia.view.crossguild.war
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.crossguild.CrossGuildTowerInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.view.base.ProgressCommon;
   
   public class CrossGuildTowerAttackFrame extends Frame implements IManualSize
   {
      
      private var _mBack:MutipleImage;
      
      private var _nameText:FilterFrameText;
      
      private var _bloodBar:ProgressCommon;
      
      private var _itemBox:VBox;
      
      private var _data:CrossGuildTowerInfo;
      
      public function CrossGuildTowerAttackFrame()
      {
         super();
         initView();
         initListView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,375,425);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _nameText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildTowerAttackFrame.nameText");
         _mBack = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildTowerAttackFrame.mBack");
         _bloodBar = ComponentFactory.Instance.creatComponentByStylename("CrossGuildTowerAttackFrame.bloodBar");
         _itemBox = ComponentFactory.Instance.creatComponentByStylename("CrossGuildTowerAttackFrame.itemBox");
         addToContent(_mBack);
         addToContent(_nameText);
         addToContent(_bloodBar);
         addToContent(_itemBox);
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:CrossGuildAttackItem = null;
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new CrossGuildAttackItem(_loc2_);
            _itemBox.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
      }
      
      public function refreshView(param1:CrossGuildTowerInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:CrossGuildAttackItem = null;
         _data = param1;
         if(!_data)
         {
            dispose();
            return;
         }
         _nameText.text = _data.nickName;
         _bloodBar.value = _data.blood / _data.totalBlood;
         _bloodBar.text = LanguageMgr.GetTranslation("CrossGuildTowerAttackFrame.bloodBar.text",_data.blood,_data.totalBlood);
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc2_ = _itemBox.getChildAt(_loc3_) as CrossGuildAttackItem;
            _loc2_.refreshView(_data);
            _loc3_++;
         }
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("CrossGuildTowerAttackFrame.titleText.text");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_mBack);
         _mBack = null;
         ObjectUtils.disposeObject(_itemBox);
         _itemBox = null;
         ObjectUtils.disposeObject(_bloodBar);
         _bloodBar = null;
         super.dispose();
      }
   }
}

