package consortia.view.crossguild.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.crossguild.CrossGuildModel;
   import yishi.manager.CrossGuildManager;
   
   public class CrossGuildDefendListView extends Component
   {
      
      private var _stateText:FilterFrameText;
      
      private var _bufferTitleText:FilterFrameText;
      
      private var _infoTitleText:FilterFrameText;
      
      private var _numTitleText:FilterFrameText;
      
      private var _textBack:Image;
      
      private var _itemBox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      public function CrossGuildDefendListView()
      {
         super();
         initView();
         refreshView();
      }
      
      private function initView() : void
      {
         _stateText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildDefendListView.stateText");
         _bufferTitleText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildDefendListView.bufferTitleText");
         _infoTitleText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildDefendListView.infoTitleText");
         _numTitleText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildDefendListView.numTitleText");
         _textBack = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildDefendListView.textBack");
         _itemBox = ComponentFactory.Instance.creatComponentByStylename("CrossGuildDefendListView.itemBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("CrossGuildDefendListView.scrollPanel");
         addChild(_numTitleText);
         addChild(_infoTitleText);
         addChild(_bufferTitleText);
         addChild(_scrollPanel);
         addChild(_textBack);
         addChild(_stateText);
         _scrollPanel.setView(_itemBox);
         this.mouseEnabled = false;
         _numTitleText.text = LanguageMgr.GetTranslation("colosseum.view.HeroRankFrame.rank");
         _infoTitleText.text = LanguageMgr.GetTranslation("CrossGuildDefendListView.infoTitleText.text");
         _bufferTitleText.text = LanguageMgr.GetTranslation("CrossGuildDefendListView.numTitleText.text");
      }
      
      public function refreshView() : void
      {
         if(model.state == 1 || model.state == 2 || model.state == 3)
         {
            _textBack.visible = true;
            _stateText.text = LanguageMgr.GetTranslation("CrossGuildDefendListView.stateText.text123");
            refreshListView(0);
         }
         else
         {
            _textBack.visible = false;
            _stateText.text = "";
            if(model.signType != 0)
            {
               if(model.defendMemberList.length >= model.defendNum)
               {
                  refreshListView(4);
               }
               else
               {
                  _textBack.visible = true;
                  refreshListView(2);
                  if(model.isValid)
                  {
                     if(model.state == 4)
                     {
                        _stateText.text = LanguageMgr.GetTranslation("CrossGuildDefendListView.stateText.text40");
                     }
                  }
                  else
                  {
                     _stateText.text = LanguageMgr.GetTranslation("CrossGuildDefendListView.stateText.text560");
                  }
               }
            }
         }
      }
      
      private function refreshListView(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:CrossGuildMemberItem = null;
         _itemBox.removeAllChild();
         var _loc3_:int = Math.min(model.defendMemberList.length,model.defendNum);
         if(param1 != 0)
         {
            _loc4_ = 1;
            while(_loc4_ <= _loc3_)
            {
               _loc2_ = new CrossGuildMemberItem(_loc4_,1);
               _loc2_.data = model.defendMemberList[_loc4_ - 1];
               _itemBox.addChild(_loc2_);
               _loc4_++;
            }
            _scrollPanel.height = 106 * param1 / 2;
            _scrollPanel.y = param1 == 4 ? 40 : 147;
         }
         _scrollPanel.beginChanges();
         _scrollPanel.invalidateViewport();
         _scrollPanel.commitChanges();
      }
      
      private function get model() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_stateText);
         _stateText = null;
         ObjectUtils.disposeObject(_bufferTitleText);
         _bufferTitleText = null;
         ObjectUtils.disposeObject(_infoTitleText);
         _infoTitleText = null;
         ObjectUtils.disposeObject(_numTitleText);
         _numTitleText = null;
         ObjectUtils.disposeObject(_textBack);
         _textBack = null;
         ObjectUtils.disposeObject(_itemBox);
         _itemBox = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         super.dispose();
      }
   }
}

